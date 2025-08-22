// export const usePlugStore = defineStore("plug", () => {
//     const connected = ref(false)
//     const principal = ref<string | null>(null)
//     const agent = ref<HttpAgent | null>(null)

//     const isLoggedIn = computed(() => connected.value && principal.value !== null)

//     async function connect() {
//         if (!window.ic?.plug) {
//             throw new Error("Plug not installed")
//         }

//         const whitelist = [/* solo los canisters de pago (ledger, treasury, etc.) */]
//         const connectedOk = await window.ic.plug.requestConnect({ whitelist })
//         if (!connectedOk) throw new Error("El usuario canceló la conexión")

//         const plugAgent = window.ic.plug.agent as HttpAgent
//         const userPrincipal = await plugAgent.getPrincipal()

//         agent.value = plugAgent
//         principal.value = userPrincipal.toText()
//         connected.value = true
//     }

//     function disconnect() {
//         connected.value = false
//         principal.value = null
//         agent.value = null
//     }

//     return { connected, principal, agent, isLoggedIn, connect, disconnect }
// })
