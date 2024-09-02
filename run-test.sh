#!/bin/bash
set -e

# Clean up
docker compose down -v --remove-orphans
docker compose build

# Start keria 0.1.2
export KERIA_IMAGE_REPO=weboftrust/keria
export KERIA_IMAGE_TAG=0.1.3
docker compose pull
docker compose up -d keria

# Start setup script
docker compose run --rm client src/setup.ts

# Stops the keria instance but keeps the volume intact
docker compose down keria

# Run migrations with new version
# export KERIA_IMAGE_TAG=0.2.0-dev3
export KERIA_IMAGE_REPO=m00sey/keria
export KERIA_IMAGE_TAG=0.2.0-dev4-sig-fix
docker compose pull
docker compose run --rm --entrypoint "/bin/bash -c" keria "find /usr/local/var/keri/db -mindepth 1 -maxdepth 1 -exec kli migrate run --name {} \;"
docker compose run --rm --entrypoint "/bin/bash -c" keria "keria sig-fix --force"

# # Start new version
docker compose up -d --force-recreate keria

# # Try to connect
docker compose run --rm client src/connect.ts

docker compose logs keria
