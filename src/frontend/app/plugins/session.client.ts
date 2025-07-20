export default defineNuxtPlugin(async (nuxtApp) => {
    const sessionStore = useSessionStore()
    console.log(sessionStore.isAuthenticated)
    await sessionStore.init()
})