<template>
  <div class="cartelera-container">
    <div class="header">
      <h2>Cartelera</h2>
    </div>
    <div class="movies-grid">
      <div v-for="movie in movies" :key="movie.id" class="movie-card">
        <div class="movie-image">{{ movie.title }} Poster</div>
        <div class="movie-info">
          <h3>{{ movie.title }}</h3>
          <p>{{ movie.description }}</p>
          <router-link :to="`/seleccion/${movie.id}`" class="select-button">Seleccionar</router-link>
        </div>
      </div>
    </div>
    <div class="actions">
      <router-link to="/perfil">Perfil</router-link>
      <button @click="logout">Cerrar Sesión</button>
    </div>
  </div>
</template>

<script>
import { movies } from '../data/movies'
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

export default {
  data() {
    return {
      movies,
    }
  },
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  methods: {
    logout() {
      this.userStore.logout()
      this.router.push('/')
    },
  },
}
</script>

<style scoped>
.cartelera-container {
  background-color: #f8f9fa;
  padding: 20px;
  min-height: 100vh;
}

.header {
  text-align: center;
  margin-bottom: 30px;
}

.header h2 {
  color: #333;
  font-size: 2.5em;
  margin-bottom: 10px;
}

.movies-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.movie-card {
  background: white;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.movie-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.movie-image {
  width: 100%;
  height: 200px;
  background: #ddd; /* Placeholder for image */
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2em;
  color: #666;
}

.movie-info {
  padding: 15px;
}

.movie-info h3 {
  margin: 0 0 10px 0;
  color: #333;
}

.movie-info p {
  color: #666;
  margin-bottom: 15px;
}

.select-button {
  background: #007bff;
  color: white;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  transition: background 0.3s ease;
}

.select-button:hover {
  background: #0056b3;
}

.actions {
  text-align: center;
  margin-top: 20px;
}

.actions a, .actions button {
  margin: 0 10px;
  text-decoration: none;
  color: #007bff;
  background: transparent;
  border: none;
  font-size: 1em;
  cursor: pointer;
  padding: 10px 15px;
  border-radius: 5px;
  transition: background 0.3s ease;
}

.actions button:hover {
  background: #007bff;
  color: white;
}
</style>
