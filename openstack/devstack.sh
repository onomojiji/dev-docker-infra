#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

# Installer les dépendances
apt-get update && apt-get install -y git sudo net-tools iproute2 curl python3-pip

# Créer utilisateur stack si inexistant
useradd -s /bin/bash -d /opt/stack -m stack || true
echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Cloner DevStack
su - stack -c "git clone https://opendev.org/openstack/devstack /opt/stack/devstack || true"

# Créer fichier local.conf minimal
cat <<EOF > /opt/stack/devstack/local.conf
[[local|localrc]]
ADMIN_PASSWORD=admin
DATABASE_PASSWORD=admin
RABBIT_PASSWORD=admin
SERVICE_PASSWORD=admin
HOST_IP=127.0.0.1
RECLONE=False
LOGFILE=/opt/stack/devstack.log
EOF

# Lancer stack.sh
su - stack -c "cd /opt/stack/devstack && ./stack.sh"
