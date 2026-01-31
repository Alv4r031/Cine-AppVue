import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    reservations: [],
  }),
  actions: {
    login(username) {
      this.user = { username }
      localStorage.setItem('user', JSON.stringify(this.user))
    },
    logout() {
      this.user = null
      localStorage.removeItem('user')
    },
    addReservation(reservation) {
      this.reservations.push(reservation)
    },
  },
})
