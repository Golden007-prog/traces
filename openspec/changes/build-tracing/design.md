# Design

- **Ingest:** `POST /v1/trace` with `Authorization: Bearer <TRACE_KEY>`. One shared key per app, set as a Worker secret. Over 200 rows a minute per key returns 429.
- **Client:** a 30-line `trace.js` copied into each app. It builds the row, then `ctx.waitUntil(fetch(...).catch(() => {}))`. Inside Cloudflare it uses a service binding (`TRACES`), as chat does for inference, because same-domain Worker calls fail with error 1033.
- **Storage:** D1 table in `schema.sql`. A daily cron deletes rows older than 14 days. At 1,000 requests a day that is about 14,000 rows.
- **Neurons:** each app sends tokens; Traces multiplies by the rate table (same `RATES` as inference) so the number is computed once.
- **Page:** read-only, GitHub login limited to `ALLOWED_LOGINS`. Sections: today's neurons per app, slowest 20, failures, route share, fallback chains.
- **Privacy:** no prompt, answer or key. `who` is a salted hash prefix.
- **Cost:** D1 and Workers free tiers. Ingest is one insert per request.
