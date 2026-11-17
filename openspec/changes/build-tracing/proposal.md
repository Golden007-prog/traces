# Proposal: Flisk Traces

## Why
On 2026-11-17 a website build on chat.flisk.si took 174 s in 2 steps and nobody could say where the time went: model, queue or retries. The free Workers AI account (10,000 neurons a day) is shared by chat, inference, gardener and docs Ask, and nothing shows who spends it. Chat has a private `task_runs` table, but the other Workers cannot use it.

## What
A Worker plus D1 at `traces.flisk.si`. Each app sends one row per request with `ctx.waitUntil`. One page shows slowest requests, failures, route used, and neurons today against the cap.

## Not in scope
Prompts, answers and keys are never stored. No paid service. No sampling UI, no alerts beyond the existing Discord webhook.

## Success
- A slow chat build can be explained in under a minute from the page.
- Neurons used today, per app, match Cloudflare's dashboard within 10%.
- Tracing adds under 5 ms to a request and never fails one.
