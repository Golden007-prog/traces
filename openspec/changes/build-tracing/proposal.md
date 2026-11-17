# Proposal: Flisk Traces

## Why
On 2026-11-17 a website build on chat.flisk.si took 174 s in 2 steps and nobody could say where the time went: model, queue or retries. The free Workers AI account (10,000 neurons a day) is shared by chat, inference, gardener and docs Ask, and nothing shows who spends it. Chat has a private `task_runs` table, but the other Workers cannot use it.

## What
A Worker plus D1 at `traces.flisk.si`. An app sends a row **only when something is wrong**: an error, a request rerouted away from its planned model, a slow one, an unexpected flow, or a cap hit. A normal request writes nothing, so the free tier is never the limit. One page lists those events.

## Not in scope
Prompts, answers and keys are never stored. No paid service. No per-request logging of normal traffic. No sampling UI, no alerts beyond the existing Discord webhook.

## Success
- A slow chat build can be explained in under a minute from the page.
- A rerouted or unexpected request shows up with what was planned and what happened.
- A normal day writes close to zero rows (under 50 a day at today's traffic).
- Tracing adds under 5 ms to a request and never fails one.
