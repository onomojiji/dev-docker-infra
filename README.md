# 📦 Infrastructure de Développement Localisée avec Docker Compose

Cette infrastructure vous fournit une stack complète pour le développement logiciel moderne avec des services prêts à l'emploi : base de données, outils de monitoring, stockage objet, CI/CD, hébergement Git, messagerie, etc.

---

## 🔧 Services Inclus

| Service       | Rôle                                                        | Accès                                             |
|---------------|-------------------------------------------------------------|---------------------------------------------------|
| PostgreSQL    | Base de données relationnelle                              | `localhost:5432` (user: `devuser`, pass: `devpass`) |
| pgAdmin       | UI Web pour PostgreSQL                                     | [http://localhost:5050](http://localhost:5050) (admin@infra.local / admin123) |
| Odoo 18       | ERP open-source pour tests et développement                | [http://localhost:8069](http://localhost:8069) |
| MailDev       | SMTP fake + boîte mail web                                 | [http://localhost:1080](http://localhost:1080) |
| Redis         | Cache/messaging, utile pour Odoo et Celery                 | `localhost:6379` |
| Adminer       | Interface SQL légère                                       | [http://localhost:8080](http://localhost:8080) |
| Portainer     | UI de gestion Docker containers                            | [http://localhost:9000](http://localhost:9000) |
| MinIO         | Serveur de stockage S3 compatible                          | [http://localhost:9001](http://localhost:9001) (minioadmin / minioadmin123) |
| Elasticsearch | Moteur de recherche / indexation                           | [http://localhost:9200](http://localhost:9200) |
| Kibana        | UI de visualisation pour Elasticsearch                     | [http://localhost:5601](http://localhost:5601) |
| RabbitMQ      | Broker de message pour communication entre services        | [http://localhost:15672](http://localhost:15672) (admin / admin123) |
| Jenkins       | Intégration continue (CI/CD)                               | [http://localhost:8081](http://localhost:8081) |
| Gitea         | Hébergement Git auto-hébergé                               | [http://localhost:3000](http://localhost:3000) |
| Grafana       | Dashboard et visualisation de métriques                    | [http://localhost:3001](http://localhost:3001) |
| Prometheus    | Collecteur de métriques compatible Grafana                 | [http://localhost:9090](http://localhost:9090) |
| Logstash      | Ingesteur de logs pour Elasticsearch                       | Entrée log à configurer sur `5044` |
| Traefik       | Reverse proxy dynamique avec gestion HTTPS automatique     | [http://localhost:8088/dashboard/](http://localhost:8088/dashboard/) |

---

## 🔌 Connexion à partir d’un projet externe

Dans vos projets Docker externes, connectez les conteneurs au réseau Docker `infra-net` en ajoutant ceci dans le `docker-compose.yml` de vos projets :

```yaml
networks:
  default:
    external:
      name: infra-net
```

Et utilisez les **noms de conteneurs** comme `postgres`, `rabbitmq`, `redis`, `minio`, etc., pour vous y connecter directement.

---

## 📊 Grafana : Visualisation des métriques

Grafana est connecté à :
- **Prometheus** : collecte les métriques de tous les conteneurs et services
- **PostgreSQL**, **RabbitMQ**, **Odoo** (via Prometheus exporters si ajoutés)
- **Elasticsearch** pour logs et recherche

---

## 🚀 Reverse Proxy Traefik avec HTTPS

Traefik détecte automatiquement les services exposés sur le réseau `infra-net`.
- Fournit des URLs dynamiques et certifiés SSL (Let's Encrypt)
- Accès : [http://localhost:8088/dashboard/](http://localhost:8088/dashboard/)

---

## ⚙️ Lancer l’infrastructure

```bash
docker compose up -d
```

Pour voir les logs :
```bash
docker compose logs -f
```

Pour arrêter :
```bash
docker compose down
```

---

## 🧩 À personnaliser selon vos besoins
- Ajouter vos projets connectés à `infra-net`
- Ajouter des exporters Prometheus pour Odoo/Redis/PostgreSQL si besoin
- Configurer Logstash pour lire des fichiers log ou syslog
