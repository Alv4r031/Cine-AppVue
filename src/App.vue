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
#app {
  font-family: 'Arial', sans-serif;
  margin: 0;
  padding: 0;
  min-height: 100vh;
  background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
  color: white;
}

button {
  margin: 10px;
  padding: 10px;
  background: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}
button:hover {
  background: #0056b3;
}

.cinema-header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: rgba(0, 0, 0, 0.8);
  padding: 10px 20px;
  z-index: 1000;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
}

.cinema-header h1 {
  margin: 0;
  color: #ffd700; /* Gold */
  font-size: 1.5em;
}
</style>
