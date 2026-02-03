const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bcrypt = require('bcrypt');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Conexión a MySQL
const db = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'cine_app',
  port: process.env.DB_PORT ? Number(process.env.DB_PORT) : 3306,
});

db.connect((err) => {
  if (err) {
    console.error('Error conectando a MySQL:', err);
    return;
  }
  console.log('Conectado a MySQL');
});

// Rutas
app.get('/api/movies', (req, res) => {
  db.query('SELECT * FROM movies', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    let trailerMap = {};
    try {
      const trailersPath = path.join(__dirname, 'trailers.json');
      if (fs.existsSync(trailersPath)) {
        const parsed = JSON.parse(fs.readFileSync(trailersPath, 'utf8')) || {};
        if (Array.isArray(parsed)) {
          parsed.forEach((item) => {
            if (!item) return;
            if (item.id) trailerMap[String(item.id)] = item.url;
            if (item.title) trailerMap[item.title] = item.url;
          });
        } else if (Array.isArray(parsed.trailers)) {
          parsed.trailers.forEach((item) => {
            if (!item) return;
            if (item.id) trailerMap[String(item.id)] = item.url;
            if (item.title) trailerMap[item.title] = item.url;
          });
        } else {
          trailerMap = parsed;
        }
      }
    } catch (e) {
      trailerMap = {};
    }

    const withTrailers = results.map((movie) => {
      const trailerFromMap = trailerMap[String(movie.id)] || trailerMap[movie.title];
      if (!movie.trailer_url && trailerFromMap) {
        return { ...movie, trailer_url: trailerFromMap };
      }
      return movie;
    });

    res.json(withTrailers);
  });
});

app.post('/api/register', async (req, res) => {
  const { name, email, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);
  db.query('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', [name, email, hashedPassword], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ id: result.insertId });
  });
});

app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(401).json({ error: 'Usuario no encontrado' });
    const user = results[0];
    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) return res.status(401).json({ error: 'Contraseña incorrecta' });
    res.json({ id: user.id, name: user.name, email: user.email });
  });
});

// Más rutas según necesites...

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});