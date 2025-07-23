import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { AuthClient } from '@dfinity/auth-client'
import { HttpAgent, AnonymousIdentity } from '@dfinity/agent'
import type { Identity, ActorSubclass } from '@dfinity/agent'
import type { User, Notification, Msg, _SERVICE } from '../../declarations/backend/backend.did'
import { createActor } from '../../declarations/backend'
import type { _SERVICE as TREASURY_SERVICE, Token} from '../../declarations/treasury/treasury.did'
import {createActor as createTreasuryActor } from '../../declarations/treasury'
const canisterId = import.meta.env.VITE_CANISTER_ID_BACKEND as string
const treasuryCanisterId = import.meta.env.VITE_CANISTER_ID_TREASURY as string
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
    const supportedTokens = ref<Token[]>([])
    const userBalances = ref<{token: string; balance: bigint}[]>([])

    const backend = ref<ActorSubclass<_SERVICE>>(createActor(canisterId, {
        agentOptions: { identity: identity.value, host }
    }))
    const treasury = ref<ActorSubclass<TREASURY_SERVICE>>(createTreasuryActor(treasuryCanisterId, {
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
        treasury.value = createTreasuryActor(treasuryCanisterId, {agent})
    }

    async function signIn() {
        if (!isAuthenticated.value) return

        try {
            supportedTokens.value = await treasury.value.getSupportedTokens()
            const response = await backend.value.signIn()
            if ('Ok' in response) {
                user.value = response.Ok.user
                notifications.value = response.Ok.notifications
                msgs.value = response.Ok.msgs
                console.log('User signed in:', user.value?.name)
                userBalances.value = await treasury.value.getMyBalances()
            }
        } catch (error) {
            console.error('Error signing in:', error)
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
        isAuthenticated, loading, isModalOpen, initialized, backend, treasury,

        // getters
        isLoggedIn, unreadNotifications, unreadMessagesCount,

        // actions
        init, setIdentity, signIn,
        updateUser, updateNotifications, updateUnreadMessages
    }
}, {
    persist: {
        storage: localStorage,
        pick: ['user', 'isAuthenticated']
    }
})

