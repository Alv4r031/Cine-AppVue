<template>
  <div class="selection-container">
    <div class="content">
      <div class="poster">
        <div class="poster-image">
          <img v-if="movie && movie.image_url" :src="movie.image_url" :alt="movie.title" />
          <div v-else class="no-image">{{ movieTitle }} Poster</div>
        </div>
        <h3 v-if="movie" class="movie-title">{{ movie.title }}</h3>
      </div>
      <div class="selection">
        <h2>Seleccionar Fecha y Horario</h2>
        <div class="selection-form">
          <div class="form-group">
            <label for="date">📅 Fecha</label>
            <input id="date" v-model="selectedDate" type="date" :min="minDate" :max="maxDate" @change="checkDate" />
            <p v-if="dateError" class="error">{{ dateError }}</p>
          </div>
          <div class="form-group">
            <label>⏰ Horario</label>
            <div class="time-buttons">
              <button
                v-for="time in availableTimes"
                :key="time"
                :class="{ active: selectedTime === time }"
                @click="selectedTime = time"
                class="time-button"
              >
                {{ time }}
              </button>
            </div>
          </div>
          <button @click="next" class="next-button">Siguiente</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { useRouter } from 'vue-router'

export default {
  data() {
    const today = new Date()
    const maxDate = new Date(today)
    maxDate.setDate(today.getDate() + 14) // 2 weeks
    return {
      movie: null,
      selectedDate: '',
      selectedTime: '',
      availableTimes: ['10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00'],
      minDate: today.toISOString().split('T')[0],
      maxDate: maxDate.toISOString().split('T')[0],
      dateError: '',
    }
  },
  setup() {
    const router = useRouter()
    return { router }
  },
  async mounted() {
    try {
      const response = await axios.get('http://localhost:3000/api/movies')
      this.movie = response.data.find(m => m.id == this.$route.params.movieId)
    } catch (error) {
      console.error('Error fetching movie:', error)
    }
  },
  computed: {
    movieTitle() {
      return this.movie ? this.movie.title : 'Película'
    },
  },
  methods: {
    checkDate() {
      if (this.selectedDate > this.maxDate) {
        this.dateError = 'No hay horario para ese día.'
        this.selectedDate = ''
      } else {
        this.dateError = ''
      }
    },
    next() {
      console.log('Selected Date:', this.selectedDate)
      console.log('Selected Time:', this.selectedTime)
      if (!this.selectedDate || !this.selectedTime || this.dateError) {
        alert('Por favor, selecciona una fecha y un horario válido.')
        return
      }
      this.router.push(`/asientos/${this.$route.params.movieId}/${this.selectedDate}/${this.selectedTime}`)
    },
  },
}
</script>

<style scoped>
.selection-container {
  background: transparent;
  padding: 80px 20px 20px;
  min-height: 100vh;
}

.content {
  display: flex;
  max-width: 1200px;
  margin: 0 auto;
  gap: 40px;
  align-items: flex-start;
}

.poster {
  flex: 0 0 350px;
  max-width: 350px;
}

.poster-image {
  width: 100%;
  height: 500px;
  background: #ddd;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
}

.poster-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
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

.movie-title {
  color: #c9a961;
  text-align: center;
  margin-top: 15px;
  font-size: 1.4em;
  font-weight: 600;
  letter-spacing: 0.5px;
}

@media (max-width: 768px) {
  .content {
    flex-direction: column;
    align-items: center;
  }

  .poster {
    flex: 0 0 auto;
    max-width: 100%;
    width: 100%;
  }

  .poster-image {
    height: 400px;
  }
}

.selection {
  flex: 1;
  min-width: 0;
}

.selection h2 {
  text-align: center;
  color: #c9a961;
  margin-bottom: 30px;
  font-size: 2em;
  font-weight: 600;
}

.selection-form {
  background: rgba(22, 33, 62, 0.85);
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(15px);
  border: 1px solid rgba(201, 169, 97, 0.3);
}

.form-group input {
  width: 100%;
  padding: 12px;
  border: 1px solid rgba(201, 169, 97, 0.5);
  border-radius: 8px;
  font-size: 1em;
  background: rgba(15, 52, 96, 0.4);
  color: #e8e8e8;
  transition: all 0.3s ease;
}

.form-group input:focus {
  outline: none;
  border-color: #c9a961;
  background: rgba(15, 52, 96, 0.6);
}

.time-buttons {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
  gap: 10px;
  margin-top: 10px;
}

.time-button {
  padding: 12px;
  background: rgba(44, 95, 125, 0.3);
  border: 1px solid #c9a961;
  border-radius: 8px;
  cursor: pointer;
  color: #e8e8e8;
  font-weight: 500;
  transition: all 0.3s ease;
}

.time-button:hover {
  background: rgba(44, 95, 125, 0.5);
  transform: translateY(-2px);
}

.time-button.active {
  background: #c9a961;
  color: #1a1a2e;
  font-weight: 600;
  box-shadow: 0 4px 8px rgba(201, 169, 97, 0.4);
}

.next-button {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #2c5f7d 0%, #1e4460 100%);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 1.1em;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(44, 95, 125, 0.4);
}

.next-button:hover {
  background: linear-gradient(135deg, #1e4460 0%, #163650 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(44, 95, 125, 0.6);
}

.error {
  color: #ff4500;
  font-size: 0.9em;
  margin-top: 5px;
}
</style>
