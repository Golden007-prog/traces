# Design

## What counts as a trace
| kind | when | example |
|---|---|---|
| error | the request returned 4xx or 5xx, or a model call threw | Wolf 502 |
| rerouted | the answering route is not the first planned one | planned `wolf`, answered by `openrouter` |
| slow | over a threshold per app (chat ask 30 s, build step 90 s, inference 20 s) | the 174 s build |
| unexpected | the flow did something it should not | bad JSON from the model, empty answer, a big app skipped the system builder, a build ended without a live link, a 3rd step failed |
| capped | a daily cap stopped a call | Workers AI over `DAILY_NEURONS`, Vercel over its cap |

Normal, correct, fast requests are not traced.

## Mechanics
- **Ingest:** `POST /v1/trace` with `Authorization: Bearer <TRACE_KEY>`, one key per app, max 100 rows a minute per key (429 after). The sender drops its own event when it is over that, so a storm of errors cannot fill D1.
- **Client:** a small `trace.js` per app: `trace(ctx, env, event)` is called only from the places above, and does `ctx.waitUntil(fetch(...).catch(() => {}))`. Inside Cloudflare it uses a service binding (`TRACES`), because same-domain Worker calls fail with error 1033.
- **Existing hooks:** chat already decides what is a problem in `runProblem` and `modelFrom` knows each fallback. Tracing reuses those, it adds no new judging.
- **Storage:** table in `schema.sql`. Daily cron deletes rows over 14 days. Same-kind repeats inside a minute for the same route are merged with a count, so one outage is one row.
- **Page:** read-only, GitHub login limited to `ALLOWED_LOGINS`. Lists the newest events by app and kind with planned versus actual route. Optional later: the existing Discord errors webhook for new `error` and `unexpected` rows.
- **Privacy:** no prompt, answer, key or login. `why` and `detail` are short and built from fixed words plus the error text.
- **Neurons:** not tracked per request. Inference already enforces `DAILY_NEURONS`; a `capped` trace shows when it bites.
