#!/usr/bin/env bash
# Upload an SBOM to Black Duck server via curl

BD_URL="https://"
API_TOKEN="your_token"
SBOM_FILE="path/to/sbom"
PROJECT_NAME=""
VERSION_NAME=""

# Authenticate
BEARER=$(curl -sk -X POST \
  "${BD_URL}/api/tokens/authenticate" \
  -H "Accept: application/vnd.blackducksoftware.user-4+json" \
  -H "Authorization: token ${API_TOKEN}" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['bearerToken'])")

if [ -z "$BEARER" ]; then
  echo "Authentication failed"
  exit 1
fi

echo "Authenticated successfully"

# Upload SBOM
curl -sk -X POST \
  "${BD_URL}/api/scan/data" \
  -H "Authorization: Bearer ${BEARER}" \
  -F "file=@${SBOM_FILE};type=application/spdx" \
  -F "pr
