import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { AuthClient } from '@dfinity/auth-client'
import { HttpAgent, AnonymousIdentity } from '@dfinity/agent'
import type { Identity, ActorSubclass } from '@dfinity/agent'
import type { User, Notification, Msg, _SERVICE } from '../declarations/backend/backend.did'
import { createActor } from '../declarations/backend'

const canisterId = import.meta.env.VITE_CANISTER_ID_BACKEND as string
const host = import.meta.env.VITE_DFX_NETWORK === 'local'
    ? `http://localhost:4943/?canisterId=rdmx6-jaaaa-aaaaa-aaadq-cai`
    : 'https://identity.ic0.app'

export const useSessionStore = defineStore('session', () => {
    // 🟢 Estado
    const user = ref<User | null>(null)
    const notifications = ref<Notification[]>([])
    const msgs = ref<Msg[]>([])
    const identity = ref<Identity>(new AnonymousIdentity())
    const isAuthenticated = ref(false)
    const loading = ref(false)
    const isModalOpen = ref(false)
    const initialized = ref(false)

    const backend = ref<ActorSubclass<_SERVICE>>(createActor(canisterId, {
        agentOptions: { identity: identity.value, host }
    }))

    // 🧠 Getters
    const isLoggedIn = computed(() => isAuthenticated.value && user.value !== null)
    const unreadNotifications = computed(() => notifications.value.filter(n => !n.read))
    const unreadMessagesCount = computed(() => msgs.value.filter(m => !m.read).length)

    // 🧩 Actions

    async function init() {
        if (initialized.value) return
        loading.value = true

        try {
            const authClient = await AuthClient.create()
            const newIdentity = authClient.getIdentity()

            await setIdentity(newIdentity)
            isAuthenticated.value = !newIdentity.getPrincipal().isAnonymous()

            if (isAuthenticated.value) {
                await signIn()
            }
        } catch (error) {
            console.error('Error initializing session:', error)
        } finally {
            loading.value = false
            initialized.value = true
        }
    }

    async function setIdentity(newIdentity: Identity) {
        identity.value = newIdentity
        const agent = await HttpAgent.create({
            identity: newIdentity,
            host
        })
        backend.value = createActor(canisterId, { agent })
    }

    async function signIn() {
        if (!isAuthenticated.value) return

        try {
            const response = await backend.value.signIn()

            if ('Ok' in response) {
                user.value = response.Ok.user
                notifications.value = response.Ok.notifications
                msgs.value = response.Ok.msgs
                console.log('User signed in:', response.Ok.user)
            }
        } catch (error) {
            console.error('Error signing in:', error)
        }
    }

    function openLoginModal() {
        isModalOpen.value = true
    }

    function closeLoginModal() {
        isModalOpen.value = false
    }

    async function login(providerUrl: string) {
        try {
            const authClient = await AuthClient.create()

            await authClient.login({
                maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000),
                identityProvider: providerUrl,
                onSuccess: async () => {
                    const newIdentity = authClient.getIdentity()
                    await setIdentity(newIdentity)
                    isAuthenticated.value = true
                    await signIn()
                },
                onError: (err) => {
                    console.error('Error al iniciar sesión:', err)
                }
            })
        } catch (error) {
            console.error('Login error:', error)
        }
    }

    async function logout() {
        try {
            user.value = null
            notifications.value = []
            msgs.value = []

            const authClient = await AuthClient.create()
            await authClient.logout()

            const anon = new AnonymousIdentity()
            await setIdentity(anon)
            isAuthenticated.value = false
        } catch (error) {
            console.error('Logout error:', error)
        }
    }

    function updateUser(u: User) {
        user.value = u
    }

    function updateNotifications(n: Notification[]) {
        notifications.value = n
    }

    function updateUnreadMessages(m: Msg[]) {
        msgs.value = m
    }

    // 🧾 Persistencia
    return {
        // state
        user, notifications, msgs, identity,
        isAuthenticated, loading, isModalOpen, initialized, backend,

        // getters
        isLoggedIn, unreadNotifications, unreadMessagesCount,

        // actions
        init, setIdentity, signIn, login, logout,
        openLoginModal, closeLoginModal,
        updateUser, updateNotifications, updateUnreadMessages
    }
}, {

})

