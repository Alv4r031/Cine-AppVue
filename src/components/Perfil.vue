<template>
  <div class="profile-container">
    <h2>Perfil</h2>
    <div v-if="userStore.reservations.length === 0" class="no-reservations">
      <p>No tienes reservas aún.</p>
    </div>
    <div v-else class="reservations-list">
      <div v-for="res in userStore.reservations" :key="res.movieId" class="reservation-card">
        <h3>{{ getMovieTitle(res.movieId) }}</h3>
        <p><strong>Fecha:</strong> {{ res.date }}</p>
        <p><strong>Hora:</strong> {{ res.time }}</p>
        <p><strong>Asientos:</strong> {{ res.seats }}</p>
        <p><strong>Total:</strong> {{ res.total }}€</p>
      </div>
    </div>
    <div class="actions">
      <router-link to="/cartelera">Volver a Cartelera</router-link>
      <button @click="logout">Cerrar Sesión</button>
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
    } catch (error) {
      console.error('Error fetching movies:', error)
    }
  },
  methods: {
    getMovieTitle(id) {
      const movie = this.movies.find(m => m.id == id)
      return movie ? movie.title : 'Desconocida'
    },
    logout() {
      this.userStore.logout()
      this.router.push('/')
    },
  },
}
</script>

<style scoped>
.profile-container {
  background: transparent;
  padding: 80px 20px 20px;
  min-height: 100vh;
}

.profile-container h2 {
  text-align: center;
  color: #c9a961;
  margin-bottom: 30px;
  font-size: 2.5em;
  font-weight: 600;
  letter-spacing: 1px;
}

.no-reservations {
  text-align: center;
  color: #e8e8e8;
  font-size: 1.3em;
  padding: 40px;
}

.reservations-list {
  max-width: 700px;
  margin: 0 auto;
}

.reservation-card {
  background: rgba(22, 33, 62, 0.85);
  padding: 25px;
  border-radius: 15px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
  margin-bottom: 20px;
  backdrop-filter: blur(15px);
  border: 1px solid rgba(201, 169, 97, 0.3);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.reservation-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.6);
}

.reservation-card h3 {
  margin-top: 0;
  color: #c9a961;
  font-size: 1.5em;
  font-weight: 600;
  margin-bottom: 15px;
}

.reservation-card p {
  margin: 10px 0;
  color: #e8e8e8;
  font-size: 1.05em;
}

.reservation-card p strong {
  color: #c9a961;
  font-weight: 600;
}

.actions {
  text-align: center;
  margin-top: 30px;
}

.actions a {
  margin: 0 10px;
  text-decoration: none;
  color: #e8e8e8;
  background: rgba(44, 95, 125, 0.6);
  border: 1px solid #c9a961;
  font-size: 1em;
  font-weight: 500;
  cursor: pointer;
  padding: 12px 24px;
  border-radius: 8px;
  transition: all 0.3s ease;
  display: inline-block;
}

.actions a:hover {
  background: rgba(44, 95, 125, 0.9);
  transform: translateY(-2px);
}

.actions button {
  margin: 0 10px;
  background: linear-gradient(135deg, #8b6f47 0%, #6b5739 100%);
  color: white;
  border: none;
  font-size: 1em;
  font-weight: 600;
  cursor: pointer;
  padding: 12px 24px;
  border-radius: 8px;
  transition: all 0.3s ease;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.actions button:hover {
  background: linear-gradient(135deg, #6b5739 0%, #5a472f 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
}
</style>
