<template>
  <div id="app">
    <header class="cinema-header">
      <h1>Cine Paradiso</h1>
    </header>
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@400;500;600&display=swap');

#app {
  font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  margin: 0;
  padding: 0;
  min-height: 100vh;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  color: #e8e8e8;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Playfair Display', Georgia, serif;
}

button {
  margin: 10px;
  padding: 10px;
  background: #2c5f7d;
  color: white;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}
button:hover {
  background: #1e4460;
}

.cinema-header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: linear-gradient(90deg, #1a1a2e 0%, #16213e 100%);
  padding: 15px 30px;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6);
  border-bottom: 2px solid #c9a961;
}

.cinema-header h1 {
  margin: 0;
  color: #c9a961;
  font-size: 1.8em;
  font-weight: 600;
  letter-spacing: 1px; /* Gold */
  font-size: 1.5em;
}
</style>
