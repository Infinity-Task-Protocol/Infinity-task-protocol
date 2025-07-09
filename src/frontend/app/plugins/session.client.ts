export default defineNuxtPlugin(nuxtApp => {
    const sessionStore = useSessionStore()
    console.log(sessionStore.isAuthenticated)
    sessionStore.init()
})