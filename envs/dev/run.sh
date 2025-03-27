#!/usr/bin/env bash

set -e

docker-compose down
docker-compose up -d
rm -f terraform.tfstate

TF_ENCRYPTION=$(cat <<EOF
key_provider "pbkdf2" "mykey" {
  passphrase = "somekeynotverysecure"
}
EOF
)
export TF_ENCRYPTION

tofu init -upgrade

sleep 20

set +e

timeout 45 sh -c 'until nc -z $0 $1; do sleep 1; done' 127.0.0.1 8080
timeout 45 sh -c 'until nc -z $0 $1; do sleep 1; done' 127.0.0.1 9000
timeout 45 sh -c 'until nc -z $0 $1; do sleep 1; done' 127.0.0.1 8200

tofu apply -auto-approve
tofu output pass
