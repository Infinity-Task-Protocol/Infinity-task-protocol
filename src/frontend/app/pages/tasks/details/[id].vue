<script setup lang="ts">
import logo5 from '@/assets/images/company/spotify.png'
import { toBigIntAmount } from '@/utils/token'
import { useTask } from '@/composables/useTask'

const { id } = useRoute().params
const session = useSessionStore()

const { taskData, bidsDetails, author, isAuthor, loadTask } = useTask()

const isBidModalOpen = ref(false)
const bidAmount = ref('')

const openBidModal = () => { isBidModalOpen.value = true }

const handleMakeBid = async () => {
  if (!taskData.value) return
  const amount = toBigIntAmount(bidAmount.value, Number(taskData.value.token.decimals))

  if (amount <= 0n) {
    console.error('Please enter a valid bid amount')
    return
  }

  const placeBidResponse = await session.backend.applyForTask({
    taskId: BigInt(id),
    amount
  })
  console.log('Bid placed:', placeBidResponse)

  isBidModalOpen.value = false
  bidAmount.value = ''
}

onMounted(async () => {
  const success = await loadTask(BigInt(id))

  console.log(taskData.value, bidsDetails.value, author.value)
  if (!success) {
    console.warn("Task not found, exiting component")
  }
})

const formatToken = (amount: bigint, decimals: bigint) => {
  const divisor = 10 ** Number(decimals)
  return (Number(amount) / divisor).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 8 })
}

const formatDate = (nanos: bigint) => {
  const ms = Number(nanos / 1000000n) // convertir nanosegundos a ms
  return new Date(ms).toLocaleDateString()
}


</script>


<template>

  <section class="bg-slate-50 dark:bg-slate-800 md:py-24 py-16">
    <div class="container mt-10">
      <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px]">
        <div class="lg:col-span-8 md:col-span-6 ">

          <div class="md:flex items-center p-6 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md bg-white dark:bg-slate-900 mb-6">
            <img :src="logo5" class="rounded-full size-28 p-4 bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">

            <div class="md:ms-4 md:mt-0 mt-6">
              <h5 class="text-xl font-semibold">{{ taskData?.title }}</h5>
              <div class="mt-2">
                <span class="text-slate-400 font-medium me-2 inline-block"><i class="uil uil-building text-[18px] text-emerald-600 me-1"></i> {{ taskData?.owner.toString() }}</span>
              </div>
            </div>
          </div>
          <h5 class="text-lg font-semibold">Tags:</h5>
          <ul class="list-none mt-5 mb-6 ">
            <li v-for="tag in taskData?.keywords" class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <div class="ms-4">
                <span class="text-emerald-600 font-medium text-sm">{{ tag}}</span>
              </div>
            </li>



          </ul>
          <h5 class="text-lg font-semibold">Task Description:</h5>
          <p></p>

          <p class="text-slate-400 mt-4">{{taskData?.description}}</p>




          <div class="mt-5" v-if="session.user && !isAuthor">
            <button
                @click="openBidModal"
                class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center rounded-md bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white md:ms-2 w-full md:w-auto"
            >
              Make Bid
            </button>
          </div>
        </div>

        <div class="lg:col-span-4 md:col-span-6">
          <JobsJobDetailSidebar v-if="bidsDetails" :hide-bids="!isAuthor" :bids="bidsDetails" :task="taskData"/>
        </div>
      </div>
    </div>
    <!-- Modal de Bid -->
    <UModal v-model:open="isBidModalOpen" title="Make Your Bid" description="Enter your bid amount for this project">
      <template #body>
        <div class="space-y-4">
          <div>
            <label for="bidAmount" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              Bid Amount ($)
            </label>
            <input
                id="bidAmount"
                v-model="bidAmount"
                type="number"
                step="0.0001"
                min="0"
                placeholder="Enter your bid amount"
                class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 dark:bg-slate-800 dark:border-slate-600 dark:text-white"
            />
          </div>
          <div class="text-sm text-gray-500 dark:text-gray-400">
            <p>Current salary range: $4000 - $4500</p>
            <p>Make sure your bid is competitive and realistic.</p>
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
              @click="handleMakeBid"
              :disabled="!bidAmount || parseFloat(bidAmount) <= 0"
              class="px-4 py-2 text-sm font-medium text-white bg-emerald-600 rounded-md hover:bg-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Submit Bid
          </button>
        </div>
      </template>
    </UModal>

  </section>
</template>




