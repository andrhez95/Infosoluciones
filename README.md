# Infosoluciones - WooCommerce Docker Compose (production-ready)

This repository now contains a production-focused Docker Compose setup for WordPress + WooCommerce behind a Cloudflare Tunnel.

Quickstart
1. Copy example env and edit secrets locally (do NOT commit .env):
   cp .env.example .env
   # Edit .env and set strong passwords and your Cloudflare tunnel details

2. Create Cloudflare Tunnel (on your machine or Cloudflare dashboard):
   - Follow Cloudflare documentation to create a tunnel and download the credentials JSON.
   - Place the credentials JSON in the `cloudflared/` directory and update `cloudflared/config.yml` replacing <TUNNEL-UUID> and hostname.

3. Start services:
   docker compose up -d

4. Initialize WordPress and install WooCommerce (use WP-CLI container):
   docker compose run --rm wp-cli wp core install --url="${WORDPRESS_URL}" --title="${WORDPRESS_TITLE}" --admin_user="${WORDPRESS_ADMIN_USER}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}"
   docker compose run --rm wp-cli wp plugin install woocommerce --activate

Notes
- DO NOT commit .env or your Cloudflare credentials JSON to the repo.
- Use the WP-CLI container to run admin and setup commands.
- You are responsible for creating the Cloudflare tunnel and uploading its credentials; this setup only runs the cloudflared client pointed at the tunnel.

If you want, I can also add an optional Traefik setup or automated backups later.
