<script setup>

const session = useSessionStore()
const { id } = useRoute().params
const taskData = await session.backend.expandTask(BigInt(id))
import logo5 from '@/assets/images/company/spotify.png'


const isAuthor = (taskData[0].author.principal.toString() === session.identity.getPrincipal().toText() )


const datas = ['Participate in requirements analysis', 'Write clean, scalable code using C# and .NET frameworks', 'Test and deploy applications and systems', 'Revise, update, refactor and debug code', 'Improve existing software', 'Develop documentation throughout the software development life cycle (SDLC', 'Serve as an expert on applications and provide technical support']

// Estado del modal
const isBidModalOpen = ref(false)
const bidAmount = ref('')

// Función para manejar el bid
const handleMakeBid = () => {
  const amount = parseFloat(bidAmount.value)

  if (!amount || amount <= 0) {
    console.error('Please enter a valid bid amount')
    return
  }

  console.log('Bid submitted:', amount)

  isBidModalOpen.value = false
  bidAmount.value = ''

  console.log('Bid submitted successfully!')
}

const openBidModal = () => {
  isBidModalOpen.value = true
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
              <h5 class="text-xl font-semibold">{{ 'Back-End Developer' }}</h5>
              <div class="mt-2">
                <span class="text-slate-400 font-medium me-2 inline-block"><i class="uil uil-building text-[18px] text-emerald-600 me-1"></i> {{ 'Lenovo pvt. ltd.' }}</span>
                <span class="text-slate-400 font-medium me-2 inline-block"><i class="uil uil-map-marker text-[18px] text-emerald-600 me-1"></i> {{ 'Beijing,    China'}}</span>
              </div>
            </div>
          </div>
          <h5 class="text-lg font-semibold">Job Information:</h5>
          <ul class="list-none mt-5 mb-6 ">
            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="user-check" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Employee Type:</p>
                <span class="text-emerald-600 font-medium text-sm">{{ 'Full Time'}}</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="map-pin" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Location:</p>
                <span class="text-emerald-600 font-medium text-sm">{{'Beijing, China'}}</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="monitor" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Job Type:</p>
                <span class="text-emerald-600 font-medium text-sm">{{ 'Back-end Developer'}}</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="briefcase" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Experience:</p>
                <span class="text-emerald-600 font-medium text-sm">2+ years</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="book" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Qualifications:</p>
                <span class="text-emerald-600 font-medium text-sm">MCA</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="dollar-sign" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Salary:</p>
                <span class="text-emerald-600 font-medium text-sm">$4000 - $4500</span>
              </div>
            </li>

            <li class="inline-flex items-center py-2 px-4 bg-white dark:bg-slate-900 me-2 my-1 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
              <i data-feather="clock" class="size-5"></i>

              <div class="ms-4">
                <p class="font-medium">Date posted:</p>
                <span class="text-emerald-600 font-medium text-sm">28th Feb, 2023</span>
              </div>
            </li>
          </ul>
          <h5 class="text-lg font-semibold">Job Description:</h5>

          <p class="text-slate-400 mt-4">One disadvantage of Lorum Ipsum is that in Latin certain letters appear more frequently than others - which creates a distinct visual impression. Moreover, in Latin only words at the beginning of sentences are capitalized.</p>
          <p class="text-slate-400 mt-4">This means that Lorem Ipsum cannot accurately represent, for example, German, in which all nouns are capitalized. Thus, Lorem Ipsum has only limited suitability as a visual filler for German texts. If the fill text is intended to illustrate the characteristics of different typefaces.</p>
          <p class="text-slate-400 mt-4">It sometimes makes sense to select texts containing the various letters and symbols specific to the output language.</p>



          <div class="mt-5" v-if="!isAuthor">
            <button
                @click="openBidModal"
                class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center rounded-md bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white md:ms-2 w-full md:w-auto"
            >
              Make Bid
            </button>
          </div>
        </div>

        <div class="lg:col-span-4 md:col-span-6">
          <JobsJobDetailSidebar :hide-bids="!isAuthor"/>
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
                step="0.01"
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




