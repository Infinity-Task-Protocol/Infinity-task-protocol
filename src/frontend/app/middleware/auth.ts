export default defineNuxtRouteMiddleware((to, from) => {
    const session = useSessionStore()

    // if not authenticated redirect to login
    if (!session.isAuthenticated) {
        return navigateTo('/')
    }
})