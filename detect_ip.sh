#!/bin/bash

# Détecter l'adresse IP locale de la machine
HOST_IP=$(ip route get 1 | awk '{print $7; exit}')

if [ -z "$HOST_IP" ]; then
  echo "❌ Impossible de détecter l'adresse IP."
  exit 1
fi

# Mise à jour du .env
if [ -f .env ]; then
  sed -i "/^HOST_IP=/d" .env
fi
echo "HOST_IP=$HOST_IP" >> .env

echo "✅ Adresse IP détectée et enregistrée dans .env : $HOST_IP"
