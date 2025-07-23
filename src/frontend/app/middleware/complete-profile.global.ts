export default defineNuxtRouteMiddleware((to) => {
    const session = useSessionStore()

    const user = session.user
    const isAuthenticated = session.isAuthenticated

    const isOnRegisterPage = to.path === '/account/register'

    // Si no está autenticado, no hacemos nada
    if (!isAuthenticated) return

    // Si está autenticado pero no tiene perfil aún
    if (!user && !isOnRegisterPage) {
        return navigateTo('/account/register')
    }

    // Si tiene perfil pero aún no está verificado
    if (user && user.verified === false && !isOnRegisterPage) {
        return navigateTo('/account/register')
    }
})
