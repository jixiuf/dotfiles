#!/bin/bash
BW_CLIENTID=$(pass show bitwarden.com |grep login| awk -F': ' '{print $2}')
BW_CLIENTSECRET=$(pass show bitwarden.com |head -n 1)
BW_MASTER=$(pass show bitwarden.com |grep master| awk -F': ' '{print $2}')
# BW_CLIENTID=$BW_CLIENTID BW_CLIENTSECRET=$BW_CLIENTSECRET bw login --apikey >/dev/null 2>/dev/null
BW_SESSION=$(BW_MASTER=$BW_MASTER bw unlock --passwordenv BW_MASTER --raw)
export BW_SESSION
# https://bitwarden.com/help/cli/
# bw get password github.com
# bw get (item|username|password|uri|totp|exposed|attachment|folder|collection|organization|org-collection|template|fingerprint) <id> [options]
bw sync  >/dev/null 2>/dev/null
bw $@
bw lock >/dev/null 2>/dev/null