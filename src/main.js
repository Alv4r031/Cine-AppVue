import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import { createPinia } from 'pinia'
import App from './App.vue'
import Login from './components/Login.vue'
import Cartelera from './components/Cartelera.vue'
import SeleccionFechaHorario from './components/SeleccionFechaHorario.vue'
import SeleccionAsientos from './components/SeleccionAsientos.vue'
import Pago from './components/Pago.vue'
import Perfil from './components/Perfil.vue'

const routes = [
  { path: '/', component: Login },
  { path: '/cartelera', component: Cartelera, meta: { requiresAuth: true } },
  { path: '/seleccion/:movieId', component: SeleccionFechaHorario, meta: { requiresAuth: true } },
  { path: '/asientos/:movieId/:date/:time', component: SeleccionAsientos, meta: { requiresAuth: true } },
  { path: '/pago', component: Pago, meta: { requiresAuth: true } },
  { path: '/perfil', component: Perfil, meta: { requiresAuth: true } },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to, from, next) => {
  const isLoggedIn = localStorage.getItem('user') // Simple auth check
  if (to.meta.requiresAuth && !isLoggedIn) {
    next('/')
  } else {
    next()
  }
})

const app = createApp(App)
app.use(router)
app.use(createPinia())
app.mount('#app')
