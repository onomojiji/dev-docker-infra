#!/bin/bash

echo "📦 Création des volumes Docker dans ./docker/volumes/ ..."

mkdir -p ./docker/volumes/postgres_data
mkdir -p ./docker/volumes/odoo_data
mkdir -p ./docker/volumes/odoo_addons
mkdir -p ./docker/volumes/portainer_data
mkdir -p ./docker/volumes/minio_data
mkdir -p ./docker/volumes/traefik_letsencrypt

echo "✅ Tous les dossiers de volumes ont été créés."
