#!/bin/bash
set -e

# Original entrypoint logic from base image
DATA_DIR="/etc/gitlab-runner"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}

CA_CERTIFICATES_PATH=${CA_CERTIFICATES_PATH:-$DATA_DIR/certs/ca.crt}
LOCAL_CA_PATH="/usr/local/share/ca-certificates/ca.crt"

update_ca() {
  echo "Updating CA certificates..."
  cp "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}"
  update-ca-certificates --fresh >/dev/null
}

if [ -f "${CA_CERTIFICATES_PATH}" ]; then
  cmp --silent "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}" || update_ca
fi

# Generate config.toml from template using gomplate
echo "Generating GitLab Runner configuration from environment variables..."
gomplate -f /tmp/config.toml.tmpl -o "${CONFIG_FILE}"

# Verify required environment variables
if [ -z "$RUNNER_TOKEN" ]; then
    echo "ERROR: RUNNER_TOKEN environment variable is required!"
    exit 1
fi

if [ -z "$RUNNER_ID" ]; then
    echo "ERROR: RUNNER_ID environment variable is required!"
    exit 1
fi

echo "Configuration generated successfully!"

# Execute the original gitlab-runner command
exec gitlab-ci-multi-runner "$@"