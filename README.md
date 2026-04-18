# Cloudflare IP 优选并生成 hosts

[English](README_en.md) | 简体中文

可以定期运行 [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest) 来获取当前网络环境下最快的 Cloudflare IP，自动生成 `hosts` 文件并同步到 GitHub Gist。

## 🚀 功能特点

- **自动测速**：根据当前的网络环境，定期寻找最快的 Cloudflare IP。
- **动态 Hosts 生成**：将你指定的域名映射到测试出的最快 IP（默认取前 2 个）。
- **GitHub Gist 同步**：自动将更新后的 hosts 内容推送到你的 GitHub Gist（支持公开或私有）。
- **容器化部署**：支持 Docker 和 Docker Compose，一键部署。
- **定时任务**：支持标准的 Cron 表达式，灵活配置执行频率。

## 🛠️ 配置说明

工具通过环境变量进行配置：

| 变量名 | 描述 | 默认值 |
| :--- | :--- | :--- |
| `DOMAINS` | 需要解析的域名列表，逗号分隔 (例如：`example1.com,example2.com`) | - |
| `GH_TOKEN` | 具有 `gist` 权限的 GitHub 个人访问令牌 (PAT) | - |
| `GIST_ID` | 需要更新的 Gist ID | - |
| `CRON` | 定时任务的 Cron 表达式 | `0 0 * * *` |
| `GIST_FILENAME` | Gist 中保存的文件名 | `hosts.txt` |
| `CF_ST_ARGS` | 传递给 `cfst` 的额外参数 | `-dn 10 -p 0 -tl 300 -tll 5` |

## 📦 快速开始

### 1. 准备工作

- **GitHub Token**: 前往 [GitHub Settings -> Tokens](https://github.com/settings/tokens) 创建一个具有 `gist` 权限的 Token。
- **Gist ID**: 在 [gist.github.com](https://gist.github.com/) 创建一个新的 Gist，从 URL 的末尾复制那串十六进制 ID。

### 2. 使用 Docker Compose 运行

创建 `docker-compose.yml` 文件：

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
      - CRON=0 3 * * *  # 每天凌晨 3 点运行
```

启动服务：

```bash
docker-compose up -d
```

### 3. 本地测试 (可选)

如果你本地安装了 Python 3.12，可以直接运行：

```bash
# 安装依赖
pip install -r requirements.txt

# 下载对应平台的 cfst 二进制文件
# 以 Linux amd64 为例：
curl -L https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/cfst_linux_amd64.tar.gz | tar -zxf - cfst

# 创建 .env 文件并配置变量，然后运行
python main.py
```

## 📜 开源协议

MIT License
