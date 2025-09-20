<script setup lang="ts">
import { ref, computed } from 'vue'
import type { Msg, Participant } from "declarations/chat/chat.did"
import type { DeliveryTask } from 'declarations/backend/backend.did'
// import { UFileUpload } from "@nuxt/ui/components/u"


const router = useRouter()

const { taskData, taskStatus, bidsDetails, author, isAuthor, loadTask } = useTask()
const session = useSessionStore()

interface Chat {
  msgs: Msg[];
  users: Participant[];
  moreMsg: boolean; 
}
const id = useRouteId('id')
const chat = ref<Chat | null >(null)
const userIndex = ref(0)

definePageMeta({
  middleware: [
    'auth',
  ],
});

let intervalId: NodeJS.Timeout | null = null;

// Función para leer el chat
async function readChat() {
  const response = await session.chat.readPaginateChat(taskData.value?.chatId[0], BigInt(0));
  if ("Ok" in response) {
    chat.value = response.Ok as Chat;
    userIndex.value = chat.value?.users?.findIndex(u =>
      u.principal.toString() === session.user?.principal.toString()
    );
  }
}

onMounted(async () => {
  if (!id) {
    console.warn("No task ID found in route params");
    return navigateTo("/");
  }

  const success = await loadTask(BigInt(id));
  if (success) {
    // Realiza la primera llamada inmediatamente
    await readChat();
    
    intervalId = setInterval(readChat, 1000);

  } else {
    console.warn("Task not found, exiting component");
    return navigateTo("/");
  }

  const userPrincipal = session.user?.principal?.toString();
  const assignedTo = taskData.value?.assignedTo?.toString() ?? null;
  // Si no eres el autor o el asignado, redirige
  if (!isAuthor && (assignedTo === userPrincipal)) {
    return await router.push("/");
  }
});

// Limpia el intervalo cuando el componente se desmonta
onUnmounted(() => {
  if (intervalId !== null) {
    clearInterval(intervalId);
  }
});

// Mock data for demonstration
const localtaskData = ref({
  title: "Build Modern Dashboard UI",
  startDate: new Date('2025-08-15'),
  endDate: new Date('2025-08-30'),
  progress: 65 // percentage
})

const milestones = ref([
  {
    id: 1,
    title: "Project Kickoff",
    description: "Initial requirements gathering",
    date: new Date('2025-08-15'),
    status: 'completed' as 'completed' | 'current' | 'upcoming'
  },
  {
    id: 2,
    title: "Wireframes & Mockups",
    description: "Create initial designs",
    date: new Date('2025-08-18'),
    status: 'completed' as 'completed' | 'current' | 'upcoming'
  },
  {
    id: 3,
    title: "Frontend Development",
    description: "Implement responsive UI components",
    date: new Date('2025-08-22'),
    status: 'current' as 'completed' | 'current' | 'upcoming'
  },
  {
    id: 4,
    title: "Testing & Optimization",
    description: "Cross-browser testing and performance",
    date: new Date('2025-08-27'),
    status: 'upcoming' as 'completed' | 'current' | 'upcoming'
  },
  {
    id: 5,
    title: "Final Delivery",
    description: "Project handover and documentation",
    date: new Date('2025-08-30'),
    status: 'upcoming' as 'completed' | 'current' | 'upcoming'
  }
])

const newMessage = ref('')
const deliveryModal = ref(false)
const deliveryReview = ref(false)


const togleDeliveryModal = () => {
  deliveryModal.value = !deliveryModal.value
}


// Computed properties
const timeRemaining = computed(() => {
  const now = new Date()
  const end = localtaskData.value.endDate
  const diff = end.getTime() - now.getTime()
  const days = Math.ceil(diff / (1000 * 60 * 60 * 24))
  return days > 0 ? `${days} days remaining` : 'Deadline passed'
})

const progressWidth = computed(() => `${localtaskData.value.progress}%`)

const formatDate = (date: Date) => {
  return date.toLocaleDateString('en-US', { 
    month: 'short', 
    day: 'numeric',
    year: 'numeric'
  })
}

const formatTime = (date: Date) => {
  return date.toLocaleTimeString('en-US', { 
    hour: '2-digit', 
    minute: '2-digit'
  })
}

const sendMessage = async () => {
  const msg = newMessage.value.trim()
  if(msg) {
    const response = await session.chat.initChat(
      [taskData.value?.assignedTo[0], taskData.value?.owner], 
      {msg: msg, multimedia: []}, 
      [{name: "Task", id: taskData.value?.id}]
    )
  } else {
    return
  }
  newMessage.value = ''
}

const getUserName = (index: BigInt) => {
  return chat.value?.users[Number(index)]?.name
}

const toogleDeliveryReview = async () => {
  const deliveries = taskData.value?.deliveries
  if (deliveries){
    console.log({deliveries})
    const lastDelivery = deliveries[deliveries.length > 0 ? deliveries.length - 1: 0]
    const response = await session.backend.checkDelivery(2)
    console.log(response)

  }

  deliveryReview.value = !deliveryModal.value
}

const form = ref({
  msg: '',
  asset: {
    data: new Uint8Array(), 
    mimeType: '',
  }
} as { msg: string; asset: { mimeType: string; data: Uint8Array } })

const handleDeliveryTask = async () => {
  const response = await session.backend.deliveryTask({
    taskId: taskData.value?.id,
    description: form.value.msg,
    asset: form.value.asset,
  })
  console.log(response)
}

function fileToUint8Array(file: File): Promise<Uint8Array> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.onload = () => {
      if (reader.result instanceof ArrayBuffer) {
        const uint8Array = new Uint8Array(reader.result)
        resolve(uint8Array)
      } else {
        reject(new Error("La lectura del archivo no resultó en un ArrayBuffer."))
      }
    }
    reader.onerror = reject
    reader.readAsArrayBuffer(file)
  })
}

async function handleFileChange(event: Event) {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  if (!file) return

  try {
    const mimeType = file.type
    const uint8Array = await fileToUint8Array(file)

    form.value.asset = {
      mimeType,
      data: uint8Array,
    }

    console.log("Archivo convertido a Uint8Array:", uint8Array)
  } catch (error) {
    console.error("Error al convertir el archivo:", error)
  }
}

</script>

<template>
  <section class="bg-slate-50 dark:bg-slate-800 min-h-screen py-16">
    <div class="container mx-auto px-4 mt-8">
      <!-- Progress Bar Header -->
      <div class="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 p-6 mb-6">
        <div class="flex items-center justify-between mb-4">
          <div>
            <h2 class="text-2xl font-bold text-slate-900 dark:text-white">{{ localtaskData.title }}</h2>
            <p class="text-slate-600 dark:text-slate-400 mt-1">{{ timeRemaining }}</p>
          </div>
          <div class="text-right">
            <div class="text-3xl font-bold text-emerald-600">{{ localtaskData.progress }}%</div>
            <div class="text-sm text-slate-500">Complete</div>
          </div>
        </div>
        
        <!-- Timeline -->
        <div class="space-y-2">
          <div class="flex justify-between text-sm text-slate-600 dark:text-slate-400">
            <span>{{ formatDate(localtaskData.startDate) }}</span>
            <span>{{ formatDate(localtaskData.endDate) }}</span>
          </div>
          <div class="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-3">
            <div 
              class="bg-gradient-to-r from-emerald-500 to-emerald-600 h-3 rounded-full transition-all duration-500 ease-out"
              :style="{ width: progressWidth }"
            ></div>
          </div>
        </div>
      </div>

      <!-- Main Content Grid -->
      <div class="grid lg:grid-cols-3 gap-6 mb-6">
        
        <!-- Chat Section -->
        <div class="lg:col-span-2">
          <UCard class="h-[600px] flex flex-col">
            <template #header>
              <div class="flex items-center gap-3">
                <div class="w-3 h-3 bg-emerald-500 rounded-full animate-pulse"></div>
                <h3 class="text-lg font-semibold">Project Chat</h3>
              </div>
            </template>

            <!-- Messages Container -->
            <div class="flex flex-col flex-1 overflow-y-auto space-y-4 mb-4 pr-2 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-600 scrollbar-track-transparent">
              <div 
                v-for="message in chat?.msgs" 
                :key="Number(message.date)"
                :class="[
                  'flex gap-3',
                  Number(message.sender) == userIndex ? 
                    'flex-row-reverse'  : 
                    'flex-row'
                ]"
              >
              
                <div :class="[
                  'max-w-xs lg:max-w-md',
                  'text-left'
                ]">
                  <div :class="[
                    'rounded-2xl px-4 py-2 text-sm',
                    Number(message.sender) == userIndex ? 
                      'bg-[#144D37]':
                      'bg-slate-100 dark:bg-slate-700 text-slate-900 dark:text-white rounded-bl-sm'
                    // session.user?.principal == message.users[message.msg.sender] ?   'text-left':'text-right'
                  ]">
                    <div :class ="[
                      'flex justify-between',
                      'mt-2 text-gray-500 text-xs',
                      'min-w-100' 
                    ]"> 
                      <span>{{ getUserName(message.sender) }}</span>
                      <!-- <span>{{ getThumbnail(message.sender) }}</span> -->
                      <span>{{ new Date(Number(message.date / 1000000n)).toLocaleString() }}</span>
                    </div>
                    <div :class="[
                      
                    ]">
                      {{ message.msg }}
                    </div>
                  </div>
                  
                </div>
              </div>
            </div>

            <!-- Message Input -->
            <div class="flex gap-2 flex-shrink-0 mt-auto">
              <UInput
                v-model="newMessage"
                placeholder="Type your message..."
                class="flex-1"
                @keyup.enter="sendMessage"
              />
              <UButton 
                @click="sendMessage"
                :disabled="!newMessage.trim()"
                icon="i-heroicons-paper-airplane"
                color="emerald"
              />
            </div>
            <div v-if="session.user?.principal.toString() == taskData?.assignedTo.toString()">
              <div
                @click="togleDeliveryModal"
                class="
                    w-60 text-center mt-50 ml-50
                    py-2.5 px-5 rounded-md font-medium text-gray-100
                    bg-gray-800 border border-gray-700
                    hover:bg-gray-700
                    shadow-sm hover:shadow-md
                    cursor-pointer
                    transition-colors duration-200 ease-in-out
                "
                >
                Delivery Task
              </div>            
            </div>
            <div v-if="session.user?.principal.toString() == taskData?.owner.toString()">

              <div
              @click="toogleDeliveryReview"
              class="
              relative w-60 text-center mt-50 ml-50
              py-3 px-6 rounded-lg font-bold text-white
              bg-green-500 hover:bg-green-800
              cursor-pointer
              transition-colors duration-50 ease-in-out animate-pulse
              "
              >
              <span class="relative z-10">Revisar Entrega</span>
            </div>
          </div>
          </UCard>
        </div>

        <!-- Delivery Modal  -->

        <UModal v-model:open="deliveryModal" title="Delivery task form">
          <template #body>  
              <div>
                <textarea 
                  name="" id="deliveryMsg"
                  class="border w-full h-30 p-2"
                  v-model="form.msg"
                >
                </textarea>

                <div class="space-y-4">
                  <input 
                    type="file"
                    @change="handleFileChange"
                    class="form-input mt-1 border" 
                  />
                </div>          
              </div>
          </template>

          <template #footer="{ close }">
            <div class="flex justify-end space-x-2">
              <button
                  @click="close"
                  class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 dark:bg-slate-700 dark:text-gray-300 dark:hover:bg-slate-600"
              >
                Cancel
              </button>
              <button
                  @click="handleDeliveryTask"
                  class="px-4 py-2 text-sm font-medium text-white bg-emerald-600 rounded-md hover:bg-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Submit Bid
              </button>
            </div>
          </template>
        </UModal>

        <UModal v-model:open="deliveryReview" title="Delivery task">
          <template #body>  
              <div>
                <textarea 
                  name="" id="deliveryMsg"
                  class="border w-full h-30 p-2"
                  v-model="form.msg"
                >
                </textarea>

                <div class="space-y-4">
                  <input 
                    type="file"
                    @change="handleFileChange"
                    class="form-input mt-1 border" 
                  />
                </div>          
              </div>
          </template>

          <template #footer="{ close }">
            <div class="flex justify-end space-x-2">
              <button
                  @click="close"
                  class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 dark:bg-slate-700 dark:text-gray-300 dark:hover:bg-slate-600"
              >
                Reject
              </button>
              <button
                  @click="handleDeliveryTask"
                  class="px-4 py-2 text-sm font-medium text-white bg-emerald-600 rounded-md hover:bg-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Accept
              </button>
            </div>
          </template>
        </UModal>



        <!-- Milestones Sidebar -->
        <div class="lg:col-span-1">
          <UCard class="h-[600px] flex flex-col">
            <template #header>
              <h3 class="text-lg font-semibold flex items-center gap-2">
                <UIcon name="i-heroicons-flag" class="w-5 h-5 text-emerald-600" />
                Milestones
              </h3>
            </template>

            <div class="flex-1 overflow-y-auto pr-2 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-600 scrollbar-track-transparent">
              <div 
                v-for="(milestone, index) in milestones" 
                :key="milestone.id"
                class="relative flex items-start gap-3 mb-4"
              >
                <!-- Timeline connector -->
                <div 
                  v-if="index < milestones.length - 1"
                  class="absolute left-3 top-8 w-0.5 h-16 bg-slate-200 dark:bg-slate-700"
                ></div>
                
                <!-- Status indicator -->
                <div :class="[
                  'w-6 h-6 rounded-full border-2 flex-shrink-0 flex items-center justify-center relative z-10',
                  milestone.status === 'completed' 
                    ? 'bg-emerald-600 border-emerald-600' 
                    : milestone.status === 'current'
                    ? 'bg-blue-600 border-blue-600'
                    : 'bg-white dark:bg-slate-900 border-slate-300 dark:border-slate-600'
                ]">
                  <UIcon 
                    v-if="milestone.status === 'completed'" 
                    name="i-heroicons-check" 
                    class="w-3 h-3 text-white" 
                  />
                  <div 
                    v-else-if="milestone.status === 'current'"
                    class="w-2 h-2 bg-white rounded-full"
                  ></div>
                </div>

                <!-- Milestone content -->
                <div class="flex-1">
                  <div class="flex items-center justify-between mb-1">
                    <h4 :class="[
                      'font-medium text-sm',
                      milestone.status === 'completed' ? 'text-slate-900 dark:text-white' : 'text-slate-700 dark:text-slate-300'
                    ]">
                      {{ milestone.title }}
                    </h4>
                    <UBadge 
                      :color="milestone.status === 'completed' ? 'emerald' : milestone.status === 'current' ? 'blue' : 'gray'"
                      variant="soft"
                      size="xs"
                    >
                      {{ milestone.status }}
                    </UBadge>
                  </div>
                  <p class="text-xs text-slate-500 dark:text-slate-400 mb-2">
                    {{ milestone.description }}
                  </p>
                  <p class="text-xs text-slate-400">
                    {{ formatDate(milestone.date) }}
                  </p>
                </div>
              </div>
            </div>
          </UCard>
        </div>
      </div>

      <!-- Delivery Button -->
      <div class="flex justify-center">
        <UButton
          @click="deliverTask"
          size="lg"
          color="emerald"
          variant="solid"
          icon="i-heroicons-cloud-arrow-up"
          :disabled="localtaskData.progress < 100"
          class="px-8 py-3 text-lg font-semibold"
        >
          {{ localtaskData.progress >= 100 ? 'Deliver Task' : 'Complete Task First' }}
        </UButton>
      </div>
    </div>
  </section>
</template>