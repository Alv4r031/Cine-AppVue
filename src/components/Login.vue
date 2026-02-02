<template>
  <div class="login-container">
    <div class="login-form">
      <div class="tabs">
        <button :class="{ active: isLogin }" @click="setMode(true)">Iniciar Sesión</button>
        <button :class="{ active: !isLogin }" @click="setMode(false)">Registrarse</button>
      </div>
      <h2>{{ isLogin ? 'Iniciar Sesión' : 'Registrarse' }}</h2>
      <form @submit.prevent="submitForm">
        <div v-if="!isLogin" class="form-group">
          <label for="name">Nombre</label>
          <input id="name" v-model="name" type="text" required />
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input id="email" v-model="email" type="email" required />
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
import axios from 'axios'
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

export default {
  data() {
    return {
      isLogin: true,
      email: '',
      password: '',
      name: '',
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
      this.email = ''
      this.password = ''
      this.name = ''
    },
    async submitForm() {
      try {
        if (this.isLogin) {
          const response = await axios.post('http://localhost:3000/api/login', {
            email: this.email,
            password: this.password
          });
          this.userStore.login(response.data);
          this.router.push('/cartelera');
        } else {
          await axios.post('http://localhost:3000/api/register', {
            name: this.name,
            email: this.email,
            password: this.password
          });
          alert('Registro exitoso. Ahora inicia sesión.');
          this.setMode(true);
        }
      } catch (error) {
        alert(error.response?.data?.error || 'Error');
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
  background: rgba(22, 33, 62, 0.9);
  padding: 40px;
  border-radius: 15px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
  width: 100%;
  max-width: 420px;
  backdrop-filter: blur(15px);
  border: 1px solid rgba(201, 169, 97, 0.3);
}

.login-form h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #c9a961;
  font-size: 1.8em;
  font-weight: 600;
}

.tabs {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.tabs button {
  flex: 1;
  padding: 12px;
  background: rgba(44, 95, 125, 0.3);
  border: 1px solid #c9a961;
  cursor: pointer;
  transition: all 0.3s ease;
  color: #e8e8e8;
  font-weight: 500;
}

.tabs button.active {
  background: #c9a961;
  color: #1a1a2e;
  font-weight: 600;
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
  margin-bottom: 8px;
  color: #c9a961;
  font-weight: 500;
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

.form-group input::placeholder {
  color: #ccc;
}

.submit-button {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #2c5f7d 0%, #1e4460 100%);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 1.05em;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(44, 95, 125, 0.4);
}

.submit-button:hover {
  background: linear-gradient(135deg, #1e4460 0%, #163650 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(44, 95, 125, 0.6);
}

.submit-button:hover {
  background: #e03e00;
}
</style>
