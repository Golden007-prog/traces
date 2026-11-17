# Tasks

## 1. Traces Worker
- [ ] 1.1 Worker, D1 database, `schema.sql`, secrets, `traces.flisk.si`
- [ ] 1.2 `POST /v1/trace` with per-key limit and validation (reject any field named prompt, answer or key)
- [ ] 1.3 Daily cleanup cron, 14 days
- [ ] 1.4 Read-only page behind GitHub login
- [ ] 1.5 Tests for ingest, limit, cleanup and the page queries

## 2. Chat first
- [ ] 2.1 Add `trace.js` to flisk-sh/chat and send one row per ask, build step and voice request
- [ ] 2.2 Record the route that answered and the fallback chain from `modelFrom`
- [ ] 2.3 Keep `task_runs` until the page covers everything it showed, then drop it

## 3. Inference
- [ ] 3.1 Send tokens, effort and neurons per call from the inference Worker
- [ ] 3.2 Compare the daily total with Cloudflare's dashboard

## 4. Rest
- [ ] 4.1 Gardener, docs Ask, fleet, board
- [ ] 4.2 Add traces.flisk.si to the flisk.si bar and flisk-emoji

## 5. Release
- [ ] 5.1 Owner deploys from fresh main; verify with one real chat build
