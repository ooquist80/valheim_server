# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Docker Compose setup for a Valheim dedicated server using `lloesche/valheim-server`. Targets x86-64 Linux (not ARM/Raspberry Pi).

## Common commands

```sh
make start    # docker compose up -d
make stop     # docker compose down (2 min grace period for world save)
make restart  # docker compose restart
make logs     # docker compose logs -f
make update   # pull latest image and restart
```

## Configuration

Edit `.env` (gitignored) before starting. See `.env.example` for all variables. Key ones:

- `SERVER_NAME` / `WORLD_NAME` / `SERVER_PASS` — server identity
- `SERVER_PUBLIC=false` — keep private (not listed in public browser)
- `BEPINEX=false` — set to `true` to enable mod support

## Adding BepInEx mods

1. Set `BEPINEX=true` in `.env`
2. Copy mod folders into `./config/bepinex/plugins/`
3. `make restart`

## Volumes

- `./config` (bind mount, gitignored) — world saves, admin/permit lists, BepInEx config
- `valheim-data` (named volume) — cached server binary (persists across updates)
