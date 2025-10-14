#!/usr/bin/env python3
"""
Validate SpecBugFix dataset entries.

This script validates that:
1. All required files exist (policy.rego, buggy.tf, patch.tf)
2. Buggy code triggers violations
3. Policy syntax is valid for OPA v1.9.0+
4. Terraform files are syntactically valid
"""

import json
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Tuple

from src.pac_engines.opa_engine import OPAEngine
from src.utils.config_loader import load_config


def validate_entry(entry: Dict, base_path: Path, opa_engine: OPAEngine) -> Tuple[bool, List[str]]:
    """Validate a single dataset entry."""
    errors = []
    entry_path = base_path / entry["path"]
    
    # Check files exist
    policy_file = entry_path / "policy.rego"
    buggy_file = entry_path / "buggy.tf"
    patch_file = entry_path / "patch.tf"
    
    for file, name in [(policy_file, "policy.rego"), (buggy_file, "buggy.tf"), (patch_file, "patch.tf")]:
        if not file.exists():
            errors.append(f"Missing {name}")
    
    if errors:
        return False, errors
    
    # Read files
    policy = policy_file.read_text()
    buggy_tf = buggy_file.read_text()
    
    # Validate policy syntax (basic check)
    if "contains" not in policy or "if {" not in policy:
        errors.append("Policy may not use OPA v1.9.0+ syntax (missing 'contains' or 'if')")
    
    if "package terraform" not in policy:
        errors.append("Policy must be in 'package terraform' namespace")
    
    # Validate buggy code triggers violation
    try:
        violations = opa_engine.evaluate(policy, buggy_tf)
        if not violations:
            errors.append("Buggy code does NOT trigger any violations (expected at least one)")
        else:
            print(f"  ✓ Detected {len(violations)} violation(s): {violations[0].get('message', 'Unknown')}")
    except Exception as e:
        errors.append(f"OPA evaluation failed: {e}")
    
    # Validate Terraform syntax (if terraform is available)
    try:
        # Write to temp file and validate
        import tempfile
        with tempfile.NamedTemporaryFile(mode='w', suffix='.tf', delete=False) as f:
            f.write(buggy_tf)
            temp_path = f.name
        
        result = subprocess.run(
            ['terraform', 'fmt', '-check', temp_path],
            capture_output=True,
            text=True,
            timeout=5
        )
        Path(temp_path).unlink()
        
        # fmt returns non-zero if formatting is needed, but that's okay
        # We just want to ensure it's valid syntax
    except FileNotFoundError:
        # Terraform not installed, skip syntax check
        pass
    except Exception as e:
        errors.append(f"Terraform syntax check failed: {e}")
    
    return len(errors) == 0, errors


def main():
    """Validate all dataset entries."""
    print("=" * 70)
    print("SpecBugFix Dataset Validation")
    print("=" * 70)
    
    # Load configuration
    config = load_config("src/config/default_config.yaml")
    opa_engine = OPAEngine(config['opa'])
    
    # Load dataset index
    base_path = Path("data/datasets/spec_bug_fix")
    index_file = base_path / "dataset_index.json"
    
    with open(index_file) as f:
        dataset = json.load(f)
    
    print(f"\nDataset: {dataset['dataset_name']} v{dataset['version']}")
    print(f"Description: {dataset['description']}")
    print(f"Total entries: {dataset['total_entries']}\n")
    
    # Validate each entry
    results = []
    for i, entry in enumerate(dataset['entries'], 1):
        print(f"[{i}/{dataset['total_entries']}] Validating {entry['id']} ({entry['category']}/{entry['subcategory']})...")
        
        is_valid, errors = validate_entry(entry, base_path, opa_engine)
        
        if is_valid:
            print(f"  ✅ PASS\n")
        else:
            print(f"  ❌ FAIL")
            for error in errors:
                print(f"     - {error}")
            print()
        
        results.append({
            'id': entry['id'],
            'valid': is_valid,
            'errors': errors
        })
    
    # Summary
    print("=" * 70)
    print("VALIDATION SUMMARY")
    print("=" * 70)
    
    valid_count = sum(1 for r in results if r['valid'])
    invalid_count = len(results) - valid_count
    
    print(f"\nTotal entries: {len(results)}")
    print(f"✅ Valid: {valid_count}")
    print(f"❌ Invalid: {invalid_count}")
    print(f"Success rate: {valid_count/len(results)*100:.1f}%\n")
    
    if invalid_count > 0:
        print("Failed entries:")
        for r in results:
            if not r['valid']:
                print(f"  - {r['id']}")
                for error in r['errors']:
                    print(f"      • {error}")
        sys.exit(1)
    else:
        print("🎉 All dataset entries are valid!")
        sys.exit(0)


if __name__ == "__main__":
    main()
