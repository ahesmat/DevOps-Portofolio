CREATE TABLE IF NOT EXISTS incidents (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  severity TEXT NOT NULL, -- 'low', 'medium', 'high', 'critical'
  status TEXT NOT NULL,   -- 'open', 'resolved'
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  resolved_at TIMESTAMPTZ
);

INSERT INTO incidents (title, description, severity, status)
VALUES
  ('DB connection errors', 'Errors connecting to primary database', 'high', 'open'),
  ('High CPU on node01', 'CPU > 90% for 10 minutes', 'medium', 'resolved');

