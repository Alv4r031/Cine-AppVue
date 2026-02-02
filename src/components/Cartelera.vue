<template>
  <div class="cartelera-container">
    <div class="header">
      <h2>Cartelera</h2>
      <div class="actions">
        <router-link to="/perfil">Perfil</router-link>
        <button @click="logout">Cerrar Sesión</button>
      </div>
    </div>
    <div class="movies-grid">
      <div v-for="movie in movies" :key="movie.id" class="movie-card">
        <div class="movie-image">
          <img v-if="movie.image_url" :src="movie.image_url" :alt="movie.title" />
          <div v-else class="no-image">{{ movie.title }}</div>
          <div class="overlay">
            <p class="overlay-description">{{ movie.description }}</p>
          </div>
        </div>
        <div class="movie-info">
          <h3>{{ movie.title }}</h3>
          <router-link :to="`/seleccion/${movie.id}`" class="select-button">Seleccionar</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

export default {
  data() {
    return {
      movies: [],
    }
  },
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  async mounted() {
    try {
      const response = await axios.get('http://localhost:3000/api/movies')
      this.movies = response.data
      console.log('Películas recibidas:', JSON.stringify(this.movies, null, 2))
    } catch (error) {
      console.error('Error fetching movies:', error)
    }
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
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 80px 20px 20px;
  min-height: 100vh;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding: 0 20px;
}

.header h2 {
  color: #c9a961;
  font-size: 2.5em;
  margin: 0;
  font-weight: 600;
  letter-spacing: 1px;
}

.movies-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 25px;
  margin-bottom: 30px;
  max-width: 1400px;
  margin-left: auto;
  margin-right: auto;
}

.movie-card {
  background: white;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
}

.movie-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
}

.movie-image {
  width: 100%;
  height: 380px;
  background: #ddd;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
}

.movie-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 0.3s ease;
}

.movie-image:hover img {
  transform: scale(1.05);
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.85);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
  padding: 20px;
}

.movie-image:hover .overlay {
  opacity: 1;
}

.overlay-description {
  color: white;
  text-align: center;
  font-size: 0.95em;
  line-height: 1.5;
  margin: 0;
}

.no-image {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2em;
  color: #666;
  text-align: center;
  padding: 20px;
}

.movie-info {
  padding: 15px;
  background: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}

.movie-info h3 {
  margin: 0;
  color: #333;
  font-size: 1.2em;
  font-weight: bold;
  text-align: center;
}

.select-button {
  background: linear-gradient(135deg, #2c5f7d 0%, #1e4460 100%);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 8px rgba(44, 95, 125, 0.3);
}

.select-button:hover {
  background: linear-gradient(135deg, #1e4460 0%, #163650 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(44, 95, 125, 0.5);
}

.actions {
  display: flex;
  gap: 10px;
  align-items: center;
}

.actions a {
  text-decoration: none;
  color: #e8e8e8;
  background: rgba(44, 95, 125, 0.6);
  border: 1px solid #c9a961;
  font-size: 1em;
  font-weight: 500;
  cursor: pointer;
  padding: 10px 20px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.actions a:hover {
  background: rgba(44, 95, 125, 0.9);
  border-color: #c9a961;
  transform: translateY(-2px);
}

.actions button {
  background: linear-gradient(135deg, #8b6f47 0%, #6b5739 100%);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.actions button:hover {
  background: linear-gradient(135deg, #6b5739 0%, #5a472f 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
}
</style>
