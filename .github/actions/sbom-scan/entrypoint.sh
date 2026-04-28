#!/bin/bash
set -e

echo "Workspace contents:"
ls -la /github/workspace

echo "Generating SBOM..."
syft requirements.txt -o cyclonedx-json=sbom.json

echo "Scanning SBOM..."
grype sbom.json --by-cve --fail-on critical
