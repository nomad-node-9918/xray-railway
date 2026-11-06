# xray-railway

Minimal Xray (VLESS + WebSocket) server for Railway.

## Deploy

- Build with the included `Dockerfile` (multi-stage, copies the official xray binary into Alpine).
- Set environment variables on Railway:
  - `UUID` — VLESS client id
  - `WS_PATH` — WebSocket path, e.g. `/ws`
- Railway provides `PORT` automatically; the entrypoint listens on it.
- Generate a public domain in Railway and use `wss://<domain><WS_PATH>` as the client endpoint.

No credentials are stored in this repository.
