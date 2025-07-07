import {useSessionStore} from "~~/stores/session";

export default defineNuxtPlugin(async () => {
    const sessionStore = useSessionStore()

    // Inicializar la sesión cuando la app se carga
    await sessionStore.init()
})