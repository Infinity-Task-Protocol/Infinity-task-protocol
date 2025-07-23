export default defineNuxtRouteMiddleware((to) => {
    const session = useSessionStore()

    // not authenticated control
    if (!session.isAuthenticated) {
        return navigateTo('/')
    }

    const user = session.user

    const isVerified = user?.verified === true

    // already verified but it comes from /account/verify
    if (isVerified && to.path === '/account/register') {
        return navigateTo('/') // o donde quieras redirigir
    }
})
