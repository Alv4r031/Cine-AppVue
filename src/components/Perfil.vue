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
import { movies } from '../data/movies'
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  methods: {
    getMovieTitle(id) {
      const movie = movies.find(m => m.id == id)
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
  color: #ffd700;
  margin-bottom: 30px;
}

.no-reservations {
  text-align: center;
  color: white;
  font-size: 1.2em;
}

.reservations-list {
  max-width: 600px;
  margin: 0 auto;
}

.reservation-card {
  background: rgba(255, 255, 255, 0.1);
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  margin-bottom: 20px;
  backdrop-filter: blur(10px);
}

.reservation-card h3 {
  margin-top: 0;
  color: #ffd700;
}

.reservation-card p {
  margin: 10px 0;
  color: white;
}

.actions {
  text-align: center;
  margin-top: 30px;
}

.actions a, .actions button {
  margin: 0 10px;
  text-decoration: none;
  color: white;
  background: #ff4500;
  border: none;
  font-size: 1em;
  cursor: pointer;
  padding: 10px 15px;
  border-radius: 5px;
  transition: background 0.3s ease;
}

.actions button:hover {
  background: #e03e00;
}
</style>
