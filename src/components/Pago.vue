<template>
  <div class="payment-container">
    <h2>Pago para {{ movieTitle }}</h2>
    <div class="reservation-summary">
      <p><strong>Fecha:</strong> {{ $route.query.date }}</p>
      <p><strong>Hora:</strong> {{ $route.query.time }}</p>
      <p><strong>Asientos:</strong> {{ $route.query.seats }}</p>
      <p><strong>Total:</strong> {{ $route.query.total }}€</p>
    </div>
    <div class="payment-methods">
      <div v-for="method in paymentMethods" :key="method.key" class="method-item">
        <button @click="selectMethod(method.key)" :class="{ active: selectedMethod === method.key }" class="method-button">
          <span class="icon">{{ method.icon }}</span>
          <span>{{ method.name }}</span>
        </button>
        <div v-if="selectedMethod === method.key" class="payment-form">
          <div v-if="selectedMethod === 'tarjeta'">
            <div class="form-group">
              <label for="cardNumber">Número de Tarjeta</label>
              <input id="cardNumber" v-model="cardNumber" type="text" placeholder="1234 5678 9012 3456" />
            </div>
            <div class="form-row">
              <div class="form-group half">
                <label for="expiry">Fecha de Caducidad</label>
                <input id="expiry" v-model="expiry" type="text" placeholder="MM/YY" />
              </div>
              <div class="form-group half">
                <label for="cvv">CVV</label>
                <input id="cvv" v-model="cvv" type="text" placeholder="123" />
              </div>
            </div>
          </div>
          <div v-if="selectedMethod === 'bizum'">
            <div class="form-group">
              <label for="phone">Número de Teléfono</label>
              <input id="phone" v-model="phone" type="text" placeholder="600 123 456" />
            </div>
          </div>
          <div v-if="selectedMethod === 'paypal'">
            <div class="form-group">
              <label for="email">Correo Electrónico</label>
              <input id="email" v-model="email" type="email" placeholder="tu@email.com" />
            </div>
          </div>
          <div v-if="selectedMethod === 'applepay'">
            <p>Apple Pay procesado automáticamente.</p>
          </div>
          <button @click="pay" class="pay-button">Pagar {{ $route.query.total }}€</button>
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
      selectedMethod: '',
      paymentMethods: [
        { key: 'tarjeta', name: 'Tarjeta', icon: '💳' },
        { key: 'bizum', name: 'Bizum', icon: '📱' },
        { key: 'paypal', name: 'PayPal', icon: '🅿️' },
        { key: 'applepay', name: 'Apple Pay', icon: '🍎' },
      ],
      cardNumber: '',
      expiry: '',
      cvv: '',
      phone: '',
      email: '',
    }
  },
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  computed: {
    movieTitle() {
      const movie = movies.find(m => m.id == this.$route.query.movieId)
      return movie ? movie.title : 'Pelicula'
    },
  },
  methods: {
    selectMethod(method) {
      this.selectedMethod = method
      // Reset fields
      this.cardNumber = ''
      this.expiry = ''
      this.cvv = ''
      this.phone = ''
      this.email = ''
    },
    pay() {
      const reservation = {
        movieId: this.$route.query.movieId,
        date: this.$route.query.date,
        time: this.$route.query.time,
        seats: this.$route.query.seats,
        total: this.$route.query.total,
      }
      this.userStore.addReservation(reservation)
      this.router.push('/perfil')
    },
  },
}
</script>

<style scoped>
.payment-container {
  background: transparent;
  padding: 80px 20px 20px;
  min-height: 100vh;
  text-align: center;
}

.payment-container h2 {
  text-align: center;
  color: #ffd700;
  margin-bottom: 30px;
}

.reservation-summary {
  background: rgba(255, 255, 255, 0.1);
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  margin-bottom: 30px;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
  backdrop-filter: blur(10px);
  text-align: left;
}

.payment-methods {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  margin-bottom: 30px;
}

.method-item {
  width: 100%;
  max-width: 400px;
}

.method-button {
  width: 100%;
  padding: 15px;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid #ffd700;
  border-radius: 5px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 10px;
  transition: all 0.3s ease;
  color: white;
}

.method-button.active {
  background: #ffd700;
  color: #0f0c29;
  transform: scale(1.05);
}

.icon {
  font-size: 1.5em;
}

.payment-form {
  margin-top: 10px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  width: 100%;
  min-height: 150px;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
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

.pay-button {
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

.pay-button:hover {
  background: #e03e00;
}
</style>
