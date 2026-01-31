<template>
  <div class="login-container">
    <div class="login-form">
      <div class="tabs">
        <button :class="{ active: isLogin }" @click="setMode(true)">Iniciar Sesión</button>
        <button :class="{ active: !isLogin }" @click="setMode(false)">Registrarse</button>
      </div>
      <h2>{{ isLogin ? 'Iniciar Sesión' : 'Registrarse' }}</h2>
      <form @submit.prevent="submitForm">
        <div class="form-group">
          <label for="username">Usuario</label>
          <input id="username" v-model="username" type="text" required />
        </div>
        <div class="form-group">
          <label for="password">Contraseña</label>
          <input id="password" v-model="password" type="password" required />
        </div>
        <button type="submit" class="submit-button">{{ isLogin ? 'Iniciar Sesión' : 'Registrarse' }}</button>
      </form>
    </div>
  </div>
</template>

<script>
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

export default {
  data() {
    return {
      isLogin: true,
      username: '',
      password: '',
    }
  },
  setup() {
    const userStore = useUserStore()
    const router = useRouter()
    return { userStore, router }
  },
  methods: {
    setMode(login) {
      this.isLogin = login
      this.username = ''
      this.password = ''
    },
    submitForm() {
      if (this.isLogin) {
        // Login logic
        const storedUser = JSON.parse(localStorage.getItem('registeredUser'))
        if (storedUser && storedUser.username === this.username && storedUser.password === this.password) {
          this.userStore.login(this.username)
          this.router.push('/cartelera')
        } else {
          alert('Credenciales incorrectas')
        }
      } else {
        // Registration logic (fictional)
        localStorage.setItem('registeredUser', JSON.stringify({ username: this.username, password: this.password }))
        alert('Registro exitoso. Ahora inicia sesión.')
        this.setMode(true)
      }
    },
  },
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: transparent; /* Inherits from App */
  padding: 20px;
}

.login-form {
  background: rgba(255, 255, 255, 0.1);
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  width: 100%;
  max-width: 400px;
  backdrop-filter: blur(10px);
}

.login-form h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #ffd700;
}

.tabs {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.tabs button {
  flex: 1;
  padding: 10px;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid #ffd700;
  cursor: pointer;
  transition: background 0.3s ease;
  color: white;
}

.tabs button.active {
  background: #ffd700;
  color: #0f0c29;
}

.tabs button:first-child {
  border-radius: 5px 0 0 5px;
}

.tabs button:last-child {
  border-radius: 0 5px 5px 0;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  color: #666;
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

.form-group input::placeholder {
  color: #ccc;
}

.submit-button {
  width: 100%;
  padding: 12px;
  background: #ff4500; /* Orange Red */
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1em;
  transition: background 0.3s ease;
}

.submit-button:hover {
  background: #e03e00;
}
</style>
