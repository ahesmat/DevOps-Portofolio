const express = require("express");
const { Pool } = require("pg");

const app = express();
app.use(express.json());

// Read DB config from env (already provided via ConfigMap + Secret)
const DB_HOST = process.env.DB_HOST || "localhost";
const DB_PORT = Number(process.env.DB_PORT || "5432");
const DB_NAME = process.env.DB_NAME || "appdb";
const DB_USER = process.env.DB_USER || "appuser";
const DB_PASSWORD = process.env.DB_PASSWORD || "password";

const PORT = Number(process.env.PORT || "80"); // listen on 80 to match your Service

const pool = new Pool({
  host: DB_HOST,
  port: DB_PORT,
  database: DB_NAME,
  user: DB_USER,
  password: DB_PASSWORD,
});

// Simple helper
async function checkDb() {
  const res = await pool.query("SELECT 1");
  return res.rows[0];
}

// GET /health – checks DB connection
app.get("/health", async (req, res) => {
  try {
    await checkDb();
    res.status(200).json({ status: "ok" });
  } catch (err) {
    console.error("Health check failed:", err.message);
    res.status(500).json({ status: "error", message: err.message });
  }
});

// GET /incidents – list all incidents
app.get("/incidents", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT id, title, description, severity, status, created_at, resolved_at
       FROM incidents
       ORDER BY created_at DESC`
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error querying incidents:", err.message);
    res.status(500).json({ error: "Failed to fetch incidents" });
  }
});

// POST /incidents – create a new incident
app.post("/incidents", async (req, res) => {
  const { title, description, severity } = req.body;

  if (!title || !severity) {
    return res.status(400).json({
      error: "title and severity are required",
    });
  }

  // Very simple validation
  const allowedSeverities = ["low", "medium", "high", "critical"];
  if (!allowedSeverities.includes(severity)) {
    return res.status(400).json({
      error: `severity must be one of: ${allowedSeverities.join(", ")}`,
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO incidents (title, description, severity, status)
       VALUES ($1, $2, $3, 'open')
       RETURNING id, title, description, severity, status, created_at, resolved_at`,
      [title, description || null, severity]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error inserting incident:", err.message);
    res.status(500).json({ error: "Failed to create incident" });
  }
});

// Basic not-found handler
app.use((req, res) => {
  res.status(404).json({ error: "Not found" });
});

// Start server
app.listen(PORT, () => {
  console.log(
    `Incident Tracker API listening on port ${PORT}. Connecting to postgres://${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME}`
  );
});

