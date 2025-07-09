# 📘 README — Infrastructure de Développement

@ Fait avec le ❤️
👤 Auteur : **onomojiji**
📝 Licence : [MIT License](https://opensource.org/licenses/MIT)

---

# 📦 Infrastructure de Développement Localisée avec Docker Compose

Cette infrastructure fournit une stack complète pour le développement logiciel moderne : base de données, ERP, monitoring, stockage objet, CI/CD, hébergement Git, messagerie, visualisation de métriques, reverse proxy dynamique, etc.

---

## 🔧 Services Inclus

| Service        | Rôle                                        | Accès                                                                             |
| -------------- | ------------------------------------------- | --------------------------------------------------------------------------------- |
| OpenStack     | plateforme Open Source qui permet de créer et gérer des clouds privés ou publics à partir de pools de ressources virtuelles               | `postgres:5432` (user: `admin`, pass: `admin`)                                |
| pgAdmin 
| PostgreSQL     | Base de données relationnelle               | `postgres:5432` (user: `devuser`, pass: `devpass`)                                |
| pgAdmin        | UI Web pour PostgreSQL                      | [http://localhost:5050](http://localhost:5050) (`pgadmin@dev.com` / `pgadmin123`) |
| Odoo 18        | ERP open-source pour tests et développement | [http://localhost:8069](http://localhost:8069)                                    |
| MinIO          | Stockage objet S3 compatible                | [http://localhost:9001](http://localhost:9001) (`minioadmin` / `minioadmin123`)   |
| RabbitMQ       | Message broker pour file d'attente          | [http://localhost:15672](http://localhost:15672) (`admin` / `admin123`)           |
| MongoDB 7      | Base de données NoSQL                       | `mongodb:27017`                                                                   |
| MongoDB 5      | Instance MongoDB rétrocompatible            | `mongodb5:27017`                                                                  |
| Mongo Express  | UI Web pour MongoDB 7                       | [http://localhost:8083](http://localhost:8083) (`admin` / `admin`)                |
| Mongo Express5 | UI Web pour MongoDB 5                       | [http://localhost:8084](http://localhost:8084) (`admin` / `admin`)                |
| Jenkins        | CI/CD pipeline automation                   | [http://localhost:8081](http://localhost:8081)                                    |
| Gitea          | Serveur Git auto-hébergé                    | [http://localhost:3000](http://localhost:3000)                                    |
| Elasticsearch  | Moteur de recherche et indexation           | [http://localhost:9200](http://localhost:9200)                                    |
| Kibana         | Visualisation des données Elasticsearch     | [http://localhost:5601](http://localhost:5601)                                    |
| Grafana        | Dashboard de monitoring                     | [http://localhost:3001](http://localhost:3001) (`admin` / `grafanaadmin123`)      |
| Prometheus     | Collecte de métriques                       | [http://localhost:9090](http://localhost:9090)                                    |
| Logstash       | Collecteur et parseur de logs               | Entrée : port `5044`                                                              |
| Traefik        | Reverse proxy dynamique + HTTPS             | [http://localhost:8088/dashboard/](http://localhost:8088/dashboard/)              |

---

## 🌐 Connexion pour vos projets externes

Dans vos autres `docker-compose.yml`, ajoutez :

```yaml
networks:
  default:
    external:
      name: infra-manager-infra-net
```

Et utilisez les noms des conteneurs (`postgres`, `rabbitmq`, `mongodb`, etc.) pour s’y connecter.

---

## 📊 Grafana & Prometheus

### 🔌 Connecté à :

* Prometheus (scraping automatique de tous les services)
* MongoDB via `mongodb_exporter`
* PostgreSQL, RabbitMQ, Docker, Odoo (via exporters intégrés ou personnalisés)

### 🧩 Dashboards intégrés :

* Docker Containers (cAdvisor)
* PostgreSQL métriques
* MongoDB métriques
* Prometheus node metrics

---

## 🚀 Traefik : Reverse Proxy & HTTPS

* Détection automatique des services exposés
* URLs personnalisables comme `odoo.localhost`, `pgadmin.localhost`
* Intégration Let's Encrypt automatique

---

## ⚙️ Lancer l’infrastructure

```bash
docker compose up -d
```

### 🔎 Voir les logs :

```bash
docker compose logs -f
```

### 🛑 Arrêter :

```bash
docker compose down
```

---

## 🔐 Variables d’environnement

Les mots de passe et utilisateurs sont définis dans le fichier `.env` :

* PostgreSQL : `devuser` / `devpass`
* MongoDB / MongoExpress : `admin` / `mongoadmin123`
* Grafana : `admin` / `grafanaadmin123`
* RabbitMQ : `admin` / `admin123`
* MinIO : `minioadmin` / `minioadmin123`
* pgAdmin : `pgadmin@dev.com` / `pgadmin123`

---

## 🛠️ Conseils d'utilisation

* Lance `fix_odoo_permissions.sh` si Odoo signale une erreur d’écriture sur `/var/lib/odoo`
* Connecte tous tes projets en développement à ce hub avec `infra-net`
* Utilise Grafana et Prometheus pour surveiller tes microservices
* Utilise Gitea ou Jenkins pour gérer ton code et CI/CD localement
