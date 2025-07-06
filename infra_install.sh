#!/bin/bash

# 1. Ajout des domaines dans /etc/hosts
DOMAINS=(
  odoo.localhost
  pgadmin.localhost
  grafana.localhost
  prometheus.localhost
  maildev.localhost
  adminer.localhost
  portainer.localhost
)

for domain in "${DOMAINS[@]}"; do
  if ! grep -q "$domain" /etc/hosts; then
    echo "127.0.0.1 $domain" | sudo tee -a /etc/hosts > /dev/null
    echo "✔️ Domaine ajouté: $domain"
  else
    echo "ℹ️ Domaine déjà présent: $domain"
  fi

done

# 2. Création des dossiers nécessaires
mkdir -p grafana_provisioning
mkdir -p grafana_dashboards

# 3. Copier les fichiers de provisioning
cp grafana_provisioning.yaml grafana_provisioning/datasources.yaml
cp grafana_dashboard_provisioning.json grafana_provisioning/dashboards.yaml
cp grafana_dashboard_docker.json grafana_dashboards/docker-dashboard.json

# 4. Affichage
echo "✅ Configuration prête. Lancer avec :"
echo "   docker compose up -d"
echo "📊 Accéder à Grafana : http://grafana.localhost"
echo "⚙️  Tous les services sont prêts à l'emploi."
