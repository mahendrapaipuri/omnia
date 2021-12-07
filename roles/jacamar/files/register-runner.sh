#! /bin/bash

# GitLab runner registration

sudo gitlab-runner register \
  --template-config /tmp/config.template.toml \
  --non-interactive \
  --url "https://gitlab.com/" \
  --registration-token "$1" \
  --executor "custom" \
  --description "jacamar-runner" \
  --tag-list "jacamar,test,g5k" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
