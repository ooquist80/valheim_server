# Valheim Dedicated Server

A Docker Compose setup for running a Valheim dedicated server on an x86-64 Linux machine, using the [`lloesche/valheim-server`](https://github.com/lloesche/valheim-server-docker) image. It runs without mods by default, and you can turn on BepInEx mod support with one setting.

## Requirements

- x86-64 Linux host (ARM / Raspberry Pi is not supported)
- [Docker](https://docs.docker.com/engine/install/) with the Compose plugin
- `make` (optional, for the shortcut commands)

## Quick start

1. Create your config from the template:

   ```sh
   cp .env.example .env
   ```

2. Edit `.env` and set at least `SERVER_NAME`, `WORLD_NAME` and `SERVER_PASS`.

3. Start the server:

   ```sh
   make start
   ```

4. Follow the logs until the server reports it is ready (the first start downloads the server files and can take several minutes):

   ```sh
   make logs
   ```

## Configuration

All settings live in `.env`, which is gitignored:

| Variable        | Default             | Description                                                  |
|-----------------|---------------------|--------------------------------------------------------------|
| `SERVER_NAME`   | `My Valheim Server` | Name shown to players                                        |
| `WORLD_NAME`    | `MyWorld`           | World save name; changing it creates or loads a different world |
| `SERVER_PASS`   | `changeme`          | Join password (must be at least 5 characters)                |
| `SERVER_PUBLIC` | `false`             | `true` lists the server in the public server browser         |
| `BEPINEX`       | `false`             | `true` enables BepInEx mod support                           |

The image supports many more options (backups, update schedules, admin lists, and so on). See the [image documentation](https://github.com/lloesche/valheim-server-docker#environment-variables) for the full list, and add any of them to `.env`.

## Commands

| Command        | What it does                                                   |
|----------------|----------------------------------------------------------------|
| `make start`   | Start the server in the background                             |
| `make stop`    | Stop the server, allowing up to 2 minutes for the world to save |
| `make restart` | Restart the server                                             |
| `make logs`    | Follow the server logs                                         |
| `make update`  | Pull the latest image and recreate the container               |

## Connecting

The server uses UDP ports **2456–2458**. On the same network, connect in-game with **Join IP** using `<host-ip>:2456`.

For friends outside your network, forward UDP ports 2456–2458 on your router to the host machine, then have them connect to `<your-public-ip>:2456`.

## Data and backups

- `./config/` holds world saves, admin/permit/ban lists and BepInEx config. It is created on first start and is gitignored. **Back up this folder** to keep your world.
- The `valheim-data` Docker volume caches the server binaries so updates don't need a full re-download. You can safely delete it.

## Adding mods (BepInEx)

1. Set `BEPINEX=true` in `.env`.
2. Copy mod folders into `./config/bepinex/plugins/`.
3. Run `make restart`.

Most mods also have to be installed on each player's client. Check each mod's documentation.
