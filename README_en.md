# Cloudflare Speed Test Gist Updater

English | [简体中文](README.md)

A lightweight tool that periodically runs [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest) to find the fastest Cloudflare IPs, updates a `hosts` file, and syncs it to a GitHub Gist.

## 🚀 Features

- **Automated Speed Testing**: Periodically checks for the fastest Cloudflare IPs based on your current network.
- **Dynamic Hosts Generation**: Maps your specified domains to the top 2 fastest IPs.
- **GitHub Gist Sync**: Automatically pushes the updated hosts content to a private or public Gist.
- **Dockerized**: Easy deployment with Docker and Docker Compose.
- **Cron Scheduling**: Flexible execution intervals using standard cron expressions.

## 🛠️ Configuration

The tool is configured via environment variables:

| Variable | Description | Default |
| :--- | :--- | :--- |
| `DOMAINS` | Comma-separated list of domains to map (e.g., `example1.com,example2.com`) | - |
| `GH_TOKEN` | GitHub Personal Access Token with `gist` scope | - |
| `GIST_ID` | The ID of the Gist you want to update | - |
| `CRON` | Cron expression for the execution interval | `0 0 * * *` |
| `GIST_FILENAME` | Name of the file in the Gist | `hosts.txt` |
| `CF_ST_ARGS` | Extra arguments for `cfst` | `-dn 10 -p 0 -tl 300 -tll 5` |

## 📦 Getting Started

### 1. Preparation

- **GitHub Token**: Go to [GitHub Settings -> Tokens](https://github.com/settings/tokens) and create a token with `gist` permissions.
- **Gist ID**: Create a new Gist at [gist.github.com](https://gist.github.com/) and copy the ID from the URL.

### 2. Run with Docker Compose

Create a `docker-compose.yml` file:

```yaml
services:
  cf-speedtest-hosts:
    image: ghcr.io/skylark36/cf-speedtest-hosts:latest
    container_name: cf-speedtest-hosts
    restart: always
    environment:
      - DOMAINS=your.domain.com
      - GH_TOKEN=your_github_personal_access_token
      - GIST_ID=your_gist_id
      - CRON=0 3 * * *  # Every day
```

Launch the service:

```bash
docker-compose up -d
```

### 3. Local Testing (Optional)

If you have Python 3.12 installed, you can run it locally:

```bash
# Install dependencies
pip install -r requirements.txt

# Download the cfst binary for your platform
# example for linux-amd64:
curl -L https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.3.4/cfst_linux_amd64.tar.gz | tar -zxf - cfst

# Create a .env file with your variables
python main.py
```

## 📜 License

MIT License
