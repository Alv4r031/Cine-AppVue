<template>
  <div class="selection-container">
    <div class="content">
      <div class="poster">
        <div class="poster-image">{{ movieTitle }} Poster</div>
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
import { movies } from '../data/movies'
import { useRouter } from 'vue-router'

export default {
  data() {
    const today = new Date()
    const maxDate = new Date(today)
    maxDate.setDate(today.getDate() + 14) // 2 weeks
    return {
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
  computed: {
    movieTitle() {
      const movie = movies.find(m => m.id == this.$route.params.movieId)
      return movie ? movie.title : 'Pelicula'
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
  max-width: 100%;
  gap: 20px;
}

.poster {
  flex: 1;
}

.poster-image {
  width: 100%;
  height: 400px;
  background: #ddd;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5em;
  color: #666;
  border-radius: 10px;
}

.selection {
  flex: 1;
}

.selection h2 {
  text-align: center;
  color: #ffd700;
  margin-bottom: 30px;
}

.selection-form {
  background: rgba(255, 255, 255, 0.1);
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ffd700;
  border-radius: 5px;
  font-size: 1em;
  background: rgba(255, 255, 255, 0.1);
  color: white;
}

.time-buttons {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
  gap: 10px;
  margin-top: 10px;
}

.time-button {
  padding: 10px;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid #ffd700;
  border-radius: 5px;
  cursor: pointer;
  color: white;
  transition: background 0.3s ease;
}

.time-button.active {
  background: #ffd700;
  color: #0f0c29;
}

.next-button {
  width: 100%;
  padding: 12px;
  background: #ff4500;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1em;
  transition: background 0.3s ease;
}

.next-button:hover {
  background: #e03e00;
}

.error {
  color: #ff4500;
  font-size: 0.9em;
  margin-top: 5px;
}
</style>
