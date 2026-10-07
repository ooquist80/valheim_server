# Plan: Containerised Valheim Dedicated Server

## Context
Docker Compose setup for a Valheim dedicated server on a local x86-64 machine, using `lloesche/valheim-server`. No mods initially, but BepInEx-ready.

## Files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Service definition, volumes, ports, env |
| `.env` | Actual server credentials and config (gitignored) |
| `.env.example` | Template checked into version control |
| `.gitignore` | Excludes `.env` and `config/` |
| `Makefile` | Shortcuts: `make start/stop/restart/logs/update` |

## Architecture

- Image: `lloesche/valheim-server:latest`
- Restart policy: `unless-stopped`
- Ports (UDP): `2456-2458`
- Volumes:
  - `./config:/config` (bind mount, gitignored) — world saves, admin/permit lists
  - `valheim-data:/opt/valheim` (named volume) — server binary cache
- `stop_grace_period: 2m` — allows the server to save the world before stopping

## Adding mods later (BepInEx)

1. Set `BEPINEX=true` in `.env`
2. Drop mod folders into `./config/bepinex/plugins/`
3. `make restart`
