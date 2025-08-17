<template>
  <div class="shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md bg-white dark:bg-slate-900 sticky top-20">
    <div class="p-6 border-t border-slate-100 dark:border-t-gray-700">
      <div class="mt-6">
        <h5 class="text-lg font-semibold text-center mb-4">Bids</h5>

        <!-- Contenedor de bids con blur condicional -->
        <div
            class="max-h-80 overflow-y-auto space-y-4 pr-2 relative transition-all duration-300"
            :class="{
            [blurClass]: hideBids,
            'pointer-events-none': hideBids,
            'blur-none pointer-events-auto': !hideBids
          }"
        >
          <!-- Sin bids -->
          <div v-if="displayBids.length === 0" class="text-center text-gray-500 dark:text-gray-400 py-6">
            No bids yet. 🕊️
          </div>
          <div
              v-for="bid in displayBids"
              :key="bid.id"
              class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg shadow-sm"
          >
            <!-- Imagen -->
            <img
                :src="bid.image"
                alt="Avatar"
                class="w-10 h-10 rounded-full object-cover"
            />

            <!-- Info -->
            <div class="flex-1 mx-4">
              <p class="font-medium text-gray-900 dark:text-white">
                {{ bid.name }}
              </p>
              <p class="text-sm text-gray-500 dark:text-gray-400">
                {{ bid.amount }} {{ bid.tokenName }}
              </p>
            </div>

            <button
                @click="openAcceptModal(bid)"
                class="bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-md text-sm font-medium transition"
            >
              Accept
            </button>
          </div>
        </div>

        <!-- Overlay con mensaje cuando está oculto -->
        <div
            v-if="hideBids && showOverlay"
            class="absolute inset-0 flex items-center justify-center bg-white/20 dark:bg-slate-900/20 backdrop-blur-sm rounded-lg"
        >
          <div class="text-center p-4">
            <div class="text-2xl mb-2">🔒</div>
            <p class="text-sm text-gray-600 dark:text-gray-400 font-medium">
              {{ overlayMessage || 'Bids are hidden' }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal de Aceptar Bid -->
    <UModal
        v-model:open="isAcceptModalOpen"
        title="Accept Bid Confirmation"
        description="Are you sure you want to accept this bid?"
    >
      <template #body>
        <div v-if="selectedBid" class="space-y-4">
          <!-- Información del bidder -->
          <div class="flex items-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <img
                :src="selectedBid.image"
                alt="Avatar"
                class="w-12 h-12 rounded-full object-cover"
            />
            <div class="ml-4 flex-1">
              <h6 class="font-semibold text-gray-900 dark:text-white">
                {{ selectedBid.name }}
              </h6>
              <p class="text-lg font-bold text-emerald-600">
                {{ selectedBid.amount }} {{selectedBid.tokenName}}
              </p>
            </div>
          </div>

          <!-- Detalles del proyecto -->
          <div class="border-t pt-4">
            <h6 class="font-medium text-gray-900 dark:text-white mb-2">
              Project Details:
            </h6>
            <ul class="text-sm text-gray-600 dark:text-gray-300 space-y-1">
              <li>• This will start the project immediately</li>
              <li>• The bidder will be notified of acceptance</li>
              <li>• Other bids will be automatically rejected</li>
              <li>• Payment will be held in escrow until completion</li>
            </ul>
          </div>

          <!-- Advertencia -->
          <div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-3">
            <div class="flex items-start">
              <div class="flex-shrink-0">
                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                </svg>
              </div>
              <div class="ml-3">
                <p class="text-sm text-yellow-800 dark:text-yellow-200">
                  <strong>Important:</strong> Once you accept this bid, you cannot undo this action.
                </p>
              </div>
            </div>
          </div>
        </div>
      </template>

      <template #footer="{ close }">
        <div class="flex justify-end space-x-3">
          <button
              @click="close"
              class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 dark:bg-slate-700 dark:text-gray-300 dark:hover:bg-slate-600 transition"
          >
            Cancel
          </button>
          <button
              @click="handleAcceptBid"
              class="px-4 py-2 text-sm font-medium text-white bg-emerald-600 rounded-md hover:bg-emerald-700 transition"
          >
            Accept Bid
          </button>
        </div>
      </template>
    </UModal>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { Principal } from '@dfinity/principal'

const session = useSessionStore()

// Estados del modal
const isAcceptModalOpen = ref(false)
const selectedBid = ref(null)

const id = ref('')
const data = ref(null)


// Props del componente
const props = defineProps({
  task: {
    type: Object,
    default: () => []
  },
  bids: {
    type: Array,
    default: () => []
  },
  hideBids: {
    type: Boolean,
    default: true
  },
  blurIntensity: {
    type: String,
    default: 'sm', // sm, md, lg, xl, 2xl, 3xl
    validator: (value) => ['none', 'sm', 'md', 'lg', 'xl', '2xl', '3xl'].includes(value)
  },
  showOverlay: {
    type: Boolean,
    default: true
  },
  overlayMessage: {
    type: String,
    default: ''
  }
})

// Computed para generar la clase de blur dinámicamente
const blurClass = computed(() => {
  if (props.blurIntensity === 'none') return 'blur-none'
  return `blur-${props.blurIntensity}`
})


const displayBids = computed(() => {
  return props.bids.map(([principal, offer], index) => {
    return {
      id: principal.toText(),
      image: 'https://api.dicebear.com/7.x/identicon/svg?seed=' + principal.toText(),
      name: principal.toText().slice(0, 10) + '...',
      amount: Number(offer.amount) / 10 ** Number(props.task.token.decimals),
      tokenName: props.task.token.symbol,
    }
  })
})


// Función para abrir el modal de aceptar
const openAcceptModal = (bid) => {
  // if (props.hideBids) return // No permitir si están ocultos
  selectedBid.value = bid
  isAcceptModalOpen.value = true
}

// Función para manejar la aceptación del bid
const handleAcceptBid = async () => {
  if (!selectedBid.value) return

  try {
    console.log('Accepting bid:', selectedBid.value)

    const taskId = BigInt(props.task.id)
    
    const bidderPrincipal = Principal.fromText(selectedBid.value.id)
    console.log({Principal : selectedBid.value.id})
    console.log(taskId)
    const response = await session.backend.acceptOffer(taskId, bidderPrincipal)
    console.log(response)
    // console.log("{task: task}")
    if("Ok" in response){
      isAcceptModalOpen.value = false
      selectedBid.value = null
      let args = response.Ok.args;
      const params = {
        to: "827d788022a863123db4294da0e5d07eb308dd5913860fb0308715dd8fbfd682",
        amount: 2000000000,
        memo: "123456789"
      }
      console.log(args.args)
      if(args.to.owner){
        // args.to = response.Ok.to_account_id
        args.to = "827d788022a863123db4294da0e5d07eb308dd5913860fb0308715dd8fbfd682"
      }
      console.log({accountID: response.Ok.to_account_id})
      console.log({args: args})
      console.log({params: params})
      // console.log({account: params.to})
      const e = await window.ic.plug.requestConnect(
        {whitelist: [props.task.token.canisterId.toString()]}
      )
      console.log({e})
    
      if (await window.ic.plug.isConnected()) {
        try {
          transferStatus = await window.ic.plug.requestTransfer(params)
          console.log({transferStatus})
        } catch (transferError) {
          console.error("Error en la transferencia:", transferError)
          transferStatus = undefined
        }
      }
      console.log("refrescar la vista como si props.task[0]?.task.status estuviera en #AcceptedOffer")
    } else {
      console.log("Este flujo quedaria deshabilitado debido al renderizado condicional vinculado a task.status")
    }

  } catch (error) {
    console.error('Error accepting bid:', error)
  }
}

</script>

<style lang="scss" scoped></style>