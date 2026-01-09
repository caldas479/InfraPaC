#!/usr/bin/env python3
"""
Filter repositories that use OPA (Open Policy Agent) with Terraform.
"""
import csv
from pathlib import Path


def filter_opa_terraform(input_file: str, output_file: str):
    """
    Filter repositories with OPA and Terraform from CSV.

    Args:
        input_file: Path to input CSV file
        output_file: Path to output CSV file
    """
    opa_terraform_repos = []

    with open(input_file, "r") as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row["pac_tool"] == "opa" and row["iac_tool"] == "Terraform":
                opa_terraform_repos.append(row)

    # Remove duplicates based on repo_name
    unique_repos = {}
    for repo in opa_terraform_repos:
        repo_name = repo["repo_name"]
        if repo_name not in unique_repos:
            unique_repos[repo_name] = repo

    # Write to output file
    with open(output_file, "w", newline="") as f:
        fieldnames = ["repo_name", "pac_tool", "iac_tool"]
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(unique_repos.values())

    print(f"Found {len(unique_repos)} unique repositories with OPA + Terraform")
    print(f"Results saved to: {output_file}")

    # Print the list
    print("\nRepositories with OPA + Terraform:")
    print("-" * 80)
    for i, repo_name in enumerate(sorted(unique_repos.keys()), 1):
        print(f"{i:3}. {repo_name}")

    return list(unique_repos.values())


if __name__ == "__main__":
    input_file = "iac-pac-repos.csv"
    output_file = "opa-terraform-repos.csv"

    filter_opa_terraform(input_file, output_file)
