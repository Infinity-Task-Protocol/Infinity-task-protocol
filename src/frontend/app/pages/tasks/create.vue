<script setup lang="ts">
import { ref } from 'vue'


definePageMeta({
  middleware: [
    'auth',
  ],
});

const session = useSessionStore()


//Todo Add getAcceptedToken function from Treasury canister

const tokens = await session.treasury.getSupportedTokens()
console.log(tokens[0])

//const acceptedTokens = session.treasury.getSupportedToken()

const form = ref({
  title: '',
  description: '',
  keywords: [] as string[],
  minReward: 0,
  maxReward: 0,
  files: [] as File[],
})

function handleFiles(e: Event) {
  const input = e.target as HTMLInputElement
  if (input.files) {
    form.value.files = Array.from(input.files)
  }
}
const admins = await session.treasury.getSupportedTokens()
const tokenSelected = ref(0)

console.log(admins)
async function handleSubmit() {
  
  const assetData = await Promise.all(
      form.value.files.map(async (file) => {
        const buffer = await file.arrayBuffer()
        return {
          data: Array.from(new Uint8Array(buffer)),
          mimeType: file.type,
        }
      })
  )

  const selectedToken = tokens[tokenSelected.value]
  
  const payload = {
    title: form.value.title,
    description: form.value.description,
    keywords: form.value.keywords,
    token: selectedToken,
    rewardRange: [
      BigInt(form.value.minReward * 10 ** Number(selectedToken.decimals)) , 
      BigInt(form.value.maxReward * 10 ** Number(selectedToken.decimals))
    ],
    assets: []
  }

  const response = await session.backend.createTask(payload)
  console.log('Task created:', response)

}
</script>

<template>
  <section class="relative bg-slate-50 dark:bg-slate-800 lg:py-24 py-16">
    <div class="container">
      <div class="lg:flex justify-center">
        <div class="lg:w-2/3">
          <div class="p-6 bg-white dark:bg-slate-900 shadow-sm rounded-md">
            <form class="text-start" @submit.prevent="handleSubmit">
              <div class="grid grid-cols-1 gap-4">
                <h5 class="text-lg font-semibold">Task Information</h5>

                <div>
                  <label class="font-semibold">Title:</label>
                  <input v-model="form.title" type="text" class="form-input mt-1 border" placeholder="Task title" />
                </div>

                <div>
                  <label class="font-semibold">Description:</label>
                  <textarea v-model="form.description" class="form-input mt-1 border" placeholder="Task description" />
                </div>

                <div>
                  <label class="font-semibold">Keywords (comma-separated):</label>
                  <UInputTags v-model="form.keywords" placeholder="Add keyword" class="form-input mt-1 border border-slate-100 dark:border-slate-800 w-full rounded-md"/>
                </div>

                <div class="grid grid-cols-3 gap-4 align-items-center">
                  <div>
                    <label class="font-semibold">Min Reward:</label>
                    <input v-model.number="form.minReward" type="number" step="any" class="form-input mt-1 border" placeholder="Minimum" />
                  </div>
                  <div>
                    <label class="font-semibold">Max Reward:</label>
                    <input v-model.number="form.maxReward" type="number" step="any" class="form-input mt-1 border" placeholder="Maximum" />
                  </div>
                  <div>
                    <label class="font-semibold">Choose an asset:</label>
                    <select name="token" id="tokenSelector" class="form-input mt-1 border">
                      <option v-for="token in tokens" :key="token.id" :value="token.id">{{ token.symbol }}</option>
                    </select>
                  </div>
                </div>

                <div>
                  <label class="font-semibold">Assets (optional):</label>
                  <input type="file" multiple @change="handleFiles" class="form-input mt-1 border" />
                </div>

                <div class="pt-4">
                  <button type="submit" class="py-2 px-4 font-semibold text-white bg-emerald-600 rounded-md hover:bg-emerald-700 transition">
                    Create Task
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
