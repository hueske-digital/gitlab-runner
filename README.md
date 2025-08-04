# GitLab Runner

Ein Docker-basierter GitLab Runner mit automatischer Konfiguration über Umgebungsvariablen.

## Übersicht

Dieses Projekt stellt einen GitLab Runner als Docker Container bereit, der sich automatisch bei der GitLab-Instanz registriert und mit konfigurierbaren Parametern ausgeführt wird.

## Voraussetzungen

- Docker und Docker Compose
- Zugriff auf eine GitLab-Instanz
- GitLab Runner Token

## Installation

1. Repository klonen:
```bash
git clone <repository-url>
cd gitlab-runner
```

2. Umgebungsvariablen konfigurieren:
```bash
cp .env.example .env
# .env Datei mit den erforderlichen Werten bearbeiten
```

3. Container starten:
```bash
docker-compose up -d
```

## Konfiguration

### Umgebungsvariablen

Die folgenden Umgebungsvariablen müssen in der `.env` Datei konfiguriert werden:

| Variable | Beschreibung | Beispiel | Pflichtfeld |
|----------|--------------|----------|-------------|
| `RUNNER_ID` | Runner ID | `123` | ✓ |
| `RUNNER_TOKEN` | GitLab Runner Token | `GR1348941...` | ✓ |
| `RUNNER_URL` | URL der GitLab-Instanz | `https://gitlab.com` | (Standard: `https://gitlab.com`) |
| `RUNNER_NAME` | Name des Runners | `local-runner` | (Standard: `local-runner`) |
| `RUNNER_CONCURRENT` | Anzahl gleichzeitiger Jobs | `5` | (Standard: `5`) |
| `RUNNER_DEFAULT_IMAGE` | Standard Docker Image | `alpine:latest` | (Standard: `alpine:latest`) |

### Erweiterte Konfiguration

Die Konfiguration wird durch das Template `build/config.toml.tmpl` gesteuert, welches beim Start des Containers mit den Umgebungsvariablen gefüllt wird.

## Architektur

### Komponenten

- **Docker Image**: Basiert auf `yobasystems/gitlab-runner:latest`
- **Gomplate**: Template-Engine zur dynamischen Konfigurationsgenerierung
- **Entrypoint Script**: Automatische Registrierung und Konfiguration beim Start

### Verzeichnisstruktur

```
gitlab-runner/
├── build/
│   ├── Dockerfile          # Docker Image Definition
│   ├── config.toml.tmpl    # GitLab Runner Konfigurationstemplate
│   └── entrypoint.sh       # Startskript
├── docker-compose.yml      # Docker Compose Konfiguration
├── .env                    # Umgebungsvariablen (nicht im Repository)
└── README.md              # Diese Datei
```