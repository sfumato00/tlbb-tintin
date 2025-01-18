CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  tlbb_id TEXT NOT NULL UNIQUE,
  env TEXT,
  vitals TEXT,
  fight_stats TEXT
);