#!/bin/bash

DEPLOY_FILE=`base64 docker-compose.yml`

cat <<EOF > deploy.json
{
  "project": "$APP_NAME",
  "compose_file": "$DEPLOY_FILE",
  "registry": {
    "url": "$REGISTRY_URL",
    "login": "$REGISTRY_USER",
    "password": "$REGISTRY_PASS"
  },
  "extra": {
    "TAG": "$CIRCLE_TAG"
    "SECRET_KEY_BASE" : "$SECRET_KEY_BASE"
  }
}
EOF

curl -H "Auth-Token: $DEPLOY_TOKEN" -X POST -d @deploy.json $DEPLOYER_URL