export default defineNuxtPlugin(async (nuxtApp) => {
    const sessionStore = useSessionStore()
    await sessionStore.init()
})