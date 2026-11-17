# Flisk Traces

Analytics for the backend. Every Flisk Worker (chat, inference, gardener, fleet, board) sends one small row per request, and one page shows what is slow, what failed and how many of the free 10,000 daily Workers AI neurons are left.

Status: planned. See [openspec/changes/build-tracing](openspec/changes/build-tracing/proposal.md).

It stores no prompts, no answers and no keys. Rows are deleted after 14 days.

MIT licence.
