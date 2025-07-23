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
          <div
              v-for="bid in bids"
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
                {{ bid.amount }} USDT
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
                {{ selectedBid.amount }} USDT
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
import { useRoute } from 'vue-router'
import logo1 from '@/assets/images/company/facebook-logo.png'
import logo2 from '@/assets/images/company/google-logo.png'
import logo3 from '@/assets/images/company/android.png'
import logo4 from '@/assets/images/company/lenovo-logo.png'
import logo5 from '@/assets/images/company/spotify.png'
import logo6 from '@/assets/images/company/linkedin.png'
import logo7 from '@/assets/images/company/circle-logo.png'
import logo8 from '@/assets/images/company/skype.png'
import logo9 from '@/assets/images/company/snapchat.png'
import logo10 from '@/assets/images/company/shree-logo.png'
import logo11 from '@/assets/images/company/telegram.png'
import logo12 from '@/assets/images/company/whatsapp.png'

const route = useRoute()

// Props del componente
const props = defineProps({
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

// Estados del modal
const isAcceptModalOpen = ref(false)
const selectedBid = ref(null)

const id = ref('')
const data = ref(null)

const bids = ref([
  { id: 1, image: logo6, name: 'John Doe', amount: 150 },
  { id: 2, image: logo7, name: 'Jane Smith', amount: 200 },
  { id: 3, image: logo8, name: 'Carlos Pérez', amount: 175 },
  { id: 4, image: logo6, name: 'Luis Gómez', amount: 180 },
  { id: 5, image: logo7, name: 'Ana López', amount: 220 },
  { id: 6, image: logo8, name: 'Zoe Rivera', amount: 250 },
])

// Función para abrir el modal de aceptar
const openAcceptModal = (bid) => {
  if (props.hideBids) return // No permitir si están ocultos
  selectedBid.value = bid
  isAcceptModalOpen.value = true
}

// Función para manejar la aceptación del bid
const handleAcceptBid = async () => {
  if (!selectedBid.value) return

  try {
    console.log('Accepting bid:', selectedBid.value)

    // Aquí llamarías a tu API
    // await session.backend.acceptBid(selectedBid.value.id, route.params.id)

    // Remover el bid aceptado y todos los demás (simulando rechazo automático)
    const acceptedBid = selectedBid.value
    bids.value = bids.value.filter(bid => bid.id === acceptedBid.id)

    // Cerrar modal
    isAcceptModalOpen.value = false
    selectedBid.value = null

    // Mostrar mensaje de éxito
    console.log('Bid accepted successfully!')

    // Aquí podrías mostrar un toast de éxito
    // toast.add({ title: 'Bid accepted successfully!', color: 'success' })

  } catch (error) {
    console.error('Error accepting bid:', error)
    // Mostrar mensaje de error
    // toast.add({ title: 'Error accepting bid', color: 'error' })
  }
}

const datas = [
  {
    id: 1,
    image: logo1,
    name: 'Facebook',
    day: '2 days ago',
    type: 'Full Time',
    job: 'Web Designer / Developer',
    country: 'Australia',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 2,
    image: logo2,
    name: 'Google',
    day: '2 days ago',
    type: 'Part Time',
    job: 'Marketing Director',
    country: 'USA',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 3,
    image: logo3,
    name: 'Android',
    day: '2 days ago',
    type: 'Remote',
    job: 'Application Developer',
    country: 'China',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 4,
    image: logo4,
    name: 'Lenovo',
    day: '2 days ago',
    type: 'WFH',
    job: 'Senior Product Designer',
    country: 'Dubai',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 5,
    image: logo5,
    name: 'Spotify',
    day: '2 days ago',
    type: 'Full Time',
    job: 'C++ Developer',
    country: 'India',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 6,
    image: logo6,
    name: 'Linkedin',
    day: '2 days ago',
    type: 'Remote',
    job: 'Php Developer',
    country: 'Pakistan',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 7,
    image: logo7,
    name: 'Circle CI',
    job: 'Web Designer / Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 8,
    image: logo8,
    name: 'Skype',
    job: 'Marketing Director',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 9,
    image: logo9,
    name: 'Snapchat',
    job: 'Application Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 10,
    image: logo10,
    name: 'Shreethemes',
    job: 'Senior Product Designer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 11,
    image: logo11,
    name: 'Telegram',
    job: 'C++ Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 12,
    image: logo12,
    name: 'Whatsapp',
    job: 'Php Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  }
]

onMounted(() => {
  id.value = route.params.id
  data.value = datas.find(item => item.id === parseInt(id.value))
})
</script>

<style lang="scss" scoped></style>