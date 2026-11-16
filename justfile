set shell := ["bash", "-euo", "pipefail", "-c"]

# Lists the source-maintenance commands.
default:
    @just --list

# Validates retained public contracts, workflows and source history without runtime execution.
check:
    just --fmt --check
    python3 -B cli-tools/validate_public_contracts.py
    actionlint
    zizmor --offline --no-progress .github
    gitleaks git --no-banner --redact .

# Runs every source check; product runtime and releases remain paused.
verify: check
