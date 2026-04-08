#!/bin/bash
# Analysis script for KICS patch generation results
# Usage: ./analyze_results.sh <log_file>

set -euo pipefail

# Check if log file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    echo "Example: $0 results/spec_bug_fix_kics/codellama/execution_20260115_000337.log"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file not found: $LOG_FILE"
    exit 1
fi

echo "========================================================================"
echo "KICS Patch Generation - Results Analysis"
echo "========================================================================"
echo ""
echo "Log file: $LOG_FILE"
echo ""

# Extract timestamps
START_TIME=$(head -1 "$LOG_FILE" | awk '{print $1, $2}' | cut -d',' -f1)
END_TIME=$(tail -100 "$LOG_FILE" | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -1 | awk '{print $1, $2}' | cut -d',' -f1)

echo "Execution Details:"
echo "  Start Time: $START_TIME"
echo "  End Time:   $END_TIME"

# Calculate duration using Python
DURATION=$(python3 <<EOF
from datetime import datetime
try:
    start = datetime.strptime("$START_TIME", '%Y-%m-%d %H:%M:%S')
    end = datetime.strptime("$END_TIME", '%Y-%m-%d %H:%M:%S')
    diff = end - start
    hours = diff.seconds // 3600
    minutes = (diff.seconds % 3600) // 60
    total_hours = diff.total_seconds() / 3600
    print(f"{hours}h {minutes}m ({total_hours:.2f} hours)")
except Exception as e:
    print("N/A")
EOF
)
echo "  Duration:   $DURATION"

# Extract worker count
WORKERS=$(grep -m1 "Workers:" "$LOG_FILE" | awk '{print $NF}' || echo "N/A")
echo "  Workers:    $WORKERS"
echo ""

# Overall statistics
SUCCESS_COUNT=$(grep -c "✓ Successfully generated patch" "$LOG_FILE" || echo 0)
FAILED_COUNT=$(grep -c "✗ Failed to generate patch" "$LOG_FILE" || echo 0)
TOTAL_PROCESSED=$((SUCCESS_COUNT + FAILED_COUNT))

if [ $TOTAL_PROCESSED -gt 0 ]; then
    SUCCESS_RATE=$(python3 -c "print(f'{($SUCCESS_COUNT / $TOTAL_PROCESSED) * 100:.1f}')")
else
    SUCCESS_RATE="N/A"
fi

echo "Overall Performance:"
echo "  Total Processed: $TOTAL_PROCESSED"
echo "  Successful:      $SUCCESS_COUNT (${SUCCESS_RATE}%)"
echo "  Failed:          $FAILED_COUNT"
echo ""

# Speed metrics
if [ $TOTAL_PROCESSED -gt 0 ]; then
    SPEED_METRICS=$(python3 <<EOF
from datetime import datetime
try:
    start = datetime.strptime("$START_TIME", '%Y-%m-%d %H:%M:%S')
    end = datetime.strptime("$END_TIME", '%Y-%m-%d %H:%M:%S')
    diff = end - start
    total_seconds = diff.total_seconds()
    avg_per_entry = total_seconds / $TOTAL_PROCESSED
    avg_per_success = total_seconds / $SUCCESS_COUNT if $SUCCESS_COUNT > 0 else 0
    print(f"{avg_per_entry:.2f} seconds per entry")
    print(f"{avg_per_success:.2f} seconds per successful patch")
except Exception as e:
    print("N/A")
    print("N/A")
EOF
)
    echo "Speed Metrics:"
    echo "  Average: $(echo "$SPEED_METRICS" | head -1)"
    echo "  Average: $(echo "$SPEED_METRICS" | tail -1)"
    echo ""
fi

# Success by iteration
echo "Success by Iteration:"
ITERATION_STATS=$(grep -E "✓ Repair successful in [0-9]+ iteration" "$LOG_FILE" | \
    sed -E 's/.*in ([0-9]+) iteration.*/\1/' | \
    sort | uniq -c | \
    awk '{printf "  Iteration %s: %s successful", $2, $1; if ('"$SUCCESS_COUNT"' > 0) printf " (%.1f%%)", ($1/'"$SUCCESS_COUNT"')*100; print ""}')

if [ -n "$ITERATION_STATS" ]; then
    echo "$ITERATION_STATS"
else
    echo "  No iteration data found"
fi

# Mean Repair Attempts (MRA)
MRA=$(grep -E "✓ Repair successful in [0-9]+ iteration" "$LOG_FILE" | \
    sed -E 's/.*in ([0-9]+) iteration.*/\1/' | \
    python3 -c "
import sys
values = [int(x.strip()) for x in sys.stdin if x.strip()]
if values:
    print(f'  Mean Repair Attempts (MRA): {sum(values)/len(values):.2f}')
    print('  (avg iterations across successful repairs — lower is more efficient)')
else:
    print('  Mean Repair Attempts (MRA): N/A')
")
echo "$MRA"
echo ""

# Category breakdown
echo "Category Breakdown:"
CATEGORIES=$(grep -E "Processing kics_(aws|azure|gcp|kubernetes|github)_" "$LOG_FILE" | \
    sed -E 's/.*Processing kics_(aws|azure|gcp|kubernetes|github)_.*/\1/' | \
    sort | uniq -c | \
    awk '{printf "  %-12s: %s entries\n", toupper($2), $1}')

if [ -n "$CATEGORIES" ]; then
    echo "$CATEGORIES"
else
    echo "  No category data found"
fi
echo ""


echo ""
echo "========================================================================"
echo "Analysis complete!"
echo "========================================================================"
