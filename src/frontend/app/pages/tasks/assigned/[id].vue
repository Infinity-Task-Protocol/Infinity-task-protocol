<script setup lang="ts">
import { ref, computed } from 'vue'
const router = useRouter()

const { taskData, bidsDetails, author, isAuthor, loadTask } = useTask()
const session = useSessionStore()

const id = useRouteId('id')

definePageMeta({
  middleware: [
    'auth',
  ],
});

onMounted(async () => {
  if (!id) {
    console.warn("No task ID found in route params")
    return navigateTo("/")
  }

  const success = await loadTask(BigInt(id))
  if (!success) {
    console.warn("Task not found, exiting component")
    return navigateTo("/")
  }

  const userPrincipal = session.user?.principal?.toString()
  const assignedTo = taskData.value?.assignedTo?.toString() ?? null

  // if you are not the author or the one assigned to the task redirect
  if (!isAuthor && (assignedTo === userPrincipal)) {
    return await router.push("/")
  }
})





// Mock data for demonstration
const localtaskData = ref({
  title: "Build Modern Dashboard UI",
  startDate: new Date('2025-08-15'),
  endDate: new Date('2025-08-30'),
  progress: 65 // percentage
})

const messages = ref([
  {
    id: 1,
    sender: 'client',
    name: 'Sarah Johnson',
    avatar: 'https://ui-avatars.io/api/?name=Sarah+Johnson&background=10b981&color=fff',
    message: "Hi! I've reviewed your initial wireframes and they look great. Can we adjust the color scheme to match our brand?",
    timestamp: new Date('2025-08-20T10:30:00'),
    isOwn: false
  },
  {
    id: 2,
    sender: 'freelancer',
    name: 'You',
    avatar: 'https://ui-avatars.io/api/?name=John+Doe&background=3b82f6&color=fff',
    message: "Absolutely! I'll update the color palette to match your brand guidelines. Could you share your brand colors?",
    timestamp: new Date('2025-08-20T10:45:00'),
    isOwn: true
  },
  {
    id: 3,
    sender: 'client',
    name: 'Sarah Johnson',
    avatar: 'https://ui-avatars.io/api/?name=Sarah+Johnson&background=10b981&color=fff',
    message: "Sure! Primary: #10b981, Secondary: #3b82f6, Accent: #f59e0b. Also, can we add a dark mode toggle?",
    timestamp: new Date('2025-08-20T11:00:00'),
    isOwn: false
  },
  {
    id: 4,
    sender: 'freelancer',
    name: 'You',
    avatar: 'https://ui-avatars.io/api/?name=John+Doe&background=3b82f6&color=fff',
    message: "Perfect! I'll implement those colors and add the dark mode toggle. Should be ready for review by tomorrow.",
    timestamp: new Date('2025-08-20T11:15:00'),
    isOwn: true
  },
  {
    id: 3,
    sender: 'client',
    name: 'Sarah Johnson',
    avatar: 'https://ui-avatars.io/api/?name=Sarah+Johnson&background=10b981&color=fff',
    message: "Sure! Primary: #10b981, Secondary: #3b82f6, Accent: #f59e0b. Also, can we add a dark mode toggle?",
    timestamp: new Date('2025-08-20T11:00:00'),
    isOwn: false
  },
  {
    id: 4,
    sender: 'freelancer',
    name: 'You',
    avatar: 'https://ui-avatars.io/api/?name=John+Doe&background=3b82f6&color=fff',
    message: "Perfect! I'll implement those colors and add the dark mode toggle. Should be ready for review by tomorrow.",
    timestamp: new Date('2025-08-20T11:15:00'),
    isOwn: true
  }
])

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

const sendMessage = () => {
  if (!newMessage.value.trim()) return
  
  messages.value.push({
    id: messages.value.length + 1,
    sender: 'freelancer',
    name: 'You',
    avatar: 'https://ui-avatars.io/api/?name=John+Doe&background=3b82f6&color=fff',
    message: newMessage.value,
    timestamp: new Date(),
    isOwn: true
  })
  
  newMessage.value = ''
}

const deliverTask = () => {
  // Handle task delivery logic here
  console.log('Delivering task...')
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
                v-for="message in messages" 
                :key="message.id"
                :class="[
                  'flex gap-3',
                  message.isOwn ? 'flex-row-reverse' : 'flex-row'
                ]"
              >
                <UAvatar 
                  :src="message.avatar" 
                  :alt="message.name"
                  size="sm"
                  class="flex-shrink-0"
                />
                <div :class="[
                  'max-w-xs lg:max-w-md',
                  message.isOwn ? 'text-right' : 'text-left'
                ]">
                  <div :class="[
                    'rounded-2xl px-4 py-2 text-sm',
                    message.isOwn 
                      ? 'bg-emerald-600 text-white rounded-br-sm' 
                      : 'bg-slate-100 dark:bg-slate-700 text-slate-900 dark:text-white rounded-bl-sm'
                  ]">
                    {{ message.message }}
                  </div>
                  <div class="text-xs text-slate-500 mt-1">
                    {{ formatTime(message.timestamp) }}
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
          </UCard>
        </div>

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