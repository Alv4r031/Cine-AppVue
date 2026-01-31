<template>
  <div class="seats-container">
    <h2>Asientos para {{ movieTitle }} - {{ $route.params.date }} {{ $route.params.time }}</h2>
    <div class="cinema-layout">
      <div class="sidebar">
        <h3>Precios de Butacas</h3>
        <ul>
          <li>Normal: 10.90€</li>
          <li>VIP: 15.90€</li>
          <li>Minusválidos: 7.90€</li>
        </ul>
        <h3>Seleccionados</h3>
        <div v-for="seat in selectedSeats" :key="seat" class="selected-seat">
          {{ seat }} - {{ getSeatType(seat) }}: {{ getSeatPrice(seat) }}€
        </div>
        <p class="total">Total: {{ totalPrice.toFixed(2) }}€</p>
        <button @click="next" class="next-button">Pagar</button>
      </div>
      <div class="main-area">
        <div class="screen">PANTALLA</div>
        <div class="seats-grid">
          <div v-for="row in 10" :key="row" class="row">
            <div
              v-for="col in 10"
              :key="col"
              :class="['seat', getSeatClass(row, col), { selected: selectedSeats.includes(`${row}-${col}`), occupied: occupiedSeats.includes(`${row}-${col}`) }]"
              @click="toggleSeat(`${row}-${col}`)"
            >
              <div class="seat-back"></div>
              <div class="seat-seat"></div>
            </div>
          </div>
        </div>
      </div>
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
      selectedSeats: [],
      occupiedSeats: [], // Remove pre-occupied
    }
  },
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  computed: {
    movieTitle() {
      const movie = movies.find(m => m.id == this.$route.params.movieId)
      return movie ? movie.title : 'Pelicula'
    },
    totalPrice() {
      return this.selectedSeats.reduce((sum, seat) => sum + this.getSeatPrice(seat), 0)
    },
  },
  mounted() {
    // Load previously reserved seats for this movie, date, time
    const movieId = this.$route.params.movieId
    const date = this.$route.params.date
    const time = this.$route.params.time
    const reservations = this.userStore.reservations.filter(r => r.movieId == movieId && r.date === date && r.time === time)
    const reservedSeats = []
    reservations.forEach(r => {
      reservedSeats.push(...r.seats.split(','))
    })
    this.occupiedSeats = [...new Set([...this.occupiedSeats, ...reservedSeats])]
  },
  methods: {
    getSeatType(seat) {
      const [row, col] = seat.split('-').map(Number)
      if (row === 1 && (col === 1 || col === 2 || col === 9 || col === 10)) return 'Minusválidos'
      if (row === 5) return 'VIP'
      return 'Normal'
    },
    getSeatPrice(seat) {
      const type = this.getSeatType(seat)
      if (type === 'Minusválidos') return 7.90
      if (type === 'VIP') return 15.90
      return 10.90
    },
    getSeatClass(row, col) {
      if (row === 1 && (col === 1 || col === 2 || col === 9 || col === 10)) return 'disabled'
      if (row === 5) return 'vip'
      return 'normal'
    },
    toggleSeat(seat) {
      if (!this.occupiedSeats.includes(seat)) {
        if (this.selectedSeats.includes(seat)) {
          this.selectedSeats = this.selectedSeats.filter(s => s !== seat)
        } else {
          this.selectedSeats.push(seat)
        }
      }
    },
    next() {
      if (this.selectedSeats.length > 0) {
        this.router.push({
          path: '/pago',
          query: {
            movieId: this.$route.params.movieId,
            date: this.$route.params.date,
            time: this.$route.params.time,
            seats: this.selectedSeats.join(','),
            total: this.totalPrice.toFixed(2),
          },
        })
      }
    },
  },
}
</script>

<style scoped>
.seats-container {
  background: transparent;
  padding: 80px 20px 20px;
  min-height: 100vh;
}

.seats-container h2 {
  text-align: center;
  color: #ffd700;
  margin-bottom: 30px;
}

.cinema-layout {
  display: flex;
  gap: 20px;
  align-items: flex-start;
}

.sidebar {
  width: 250px;
  background: rgba(255, 255, 255, 0.1);
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  color: white;
}

.sidebar h3 {
  margin-top: 0;
  color: #ffd700;
}

.sidebar ul {
  list-style: none;
  padding: 0;
}

.sidebar li {
  margin-bottom: 10px;
}

.selected-seat {
  margin-bottom: 5px;
}

.total {
  font-weight: bold;
  font-size: 1.2em;
  color: #ffd700;
}

.main-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.screen {
  width: 80%;
  height: 50px;
  background: #333;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2em;
  border-radius: 5px 5px 20px 20px;
  margin-bottom: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

.seats-grid {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.row {
  display: flex;
  margin-bottom: 10px;
}

.seat {
  width: 45px;
  height: 45px;
  margin: 3px;
  cursor: pointer;
  position: relative;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}

.seat-back {
  width: 35px;
  height: 25px;
  position: absolute;
  top: 2px;
  left: 5px;
  border-radius: 5px 5px 2px 2px;
  border: 1px solid #1e7e34;
}

.seat-seat {
  width: 35px;
  height: 18px;
  position: absolute;
  bottom: 2px;
  left: 5px;
  border-radius: 2px 2px 5px 5px;
  border: 1px solid #1e7e34;
}

.seat.normal .seat-back, .seat.normal .seat-seat {
  background: linear-gradient(135deg, #28a745, #20c997);
}

.seat.vip .seat-back, .seat.vip .seat-seat {
  background: linear-gradient(135deg, #ffd700, #ffed4e);
  border-color: #b8860b;
}

.seat.disabled .seat-back, .seat.disabled .seat-seat {
  background: linear-gradient(135deg, #17a2b8, #138496);
  border-color: #117a8b;
}

.seat.selected .seat-back {
  background: linear-gradient(135deg, #6c757d, #5a6268);
}

.seat.selected .seat-seat {
  background: linear-gradient(135deg, #5a6268, #6c757d);
}

.seat.occupied .seat-back {
  background: linear-gradient(135deg, #dc3545, #c82333);
}

.seat.occupied .seat-seat {
  background: linear-gradient(135deg, #c82333, #dc3545);
}

.seat:hover:not(.occupied) {
  transform: scale(1.1);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
}

.selected-info {
  display: none; /* Hide since it's in sidebar */
}

.next-button {
  display: block;
  margin: 0 auto;
  padding: 12px 20px;
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
</style>
