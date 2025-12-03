#! /bin/bash
find data/datasets/spec_bug_fix/opa -name "patch.tf" -type f -exec truncate -s 0 {} \;