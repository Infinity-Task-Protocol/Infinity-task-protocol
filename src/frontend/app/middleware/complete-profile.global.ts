export default defineNuxtRouteMiddleware((to) => {
    const session = useSessionStore()
    if (!session.isAuthenticated) return



    const isAuthenticated = session.isAuthenticated
    const isProfileComplete = session.user

    const isOnProfilePage = to.path === '/account/register'

    console.log(isProfileComplete, "is authenticated", isAuthenticated)
    if (isAuthenticated && !isProfileComplete && !isOnProfilePage) {
        return navigateTo('/account/register')
    }
})
