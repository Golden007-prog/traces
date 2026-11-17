-- One row per backend request. No prompt, no answer, no key, no login (only a short hash of it, to count people).
CREATE TABLE IF NOT EXISTS traces (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created TEXT NOT NULL,
  app TEXT NOT NULL,            -- chat | inference | gardener | fleet | board
  route TEXT NOT NULL,          -- /api/ask, /v1/chat/completions, ...
  who TEXT,                     -- first 8 hex of sha256(login + salt), or null
  route_taken TEXT,             -- own-key | wolf | openrouter-free | vercel | workers-ai | pollinations
  model TEXT,
  effort TEXT,                  -- low | medium
  tokens_in INTEGER,
  tokens_out INTEGER,
  neurons REAL,                 -- Workers AI neurons, estimated from the rate table
  ms INTEGER NOT NULL,
  steps INTEGER,
  status INTEGER NOT NULL,      -- HTTP status we returned
  error TEXT,                   -- first 200 characters, no prompt text
  fallbacks TEXT                -- "wolf:429>openrouter:ok"
);
CREATE INDEX IF NOT EXISTS traces_created ON traces (created);
CREATE INDEX IF NOT EXISTS traces_app ON traces (app, created);
