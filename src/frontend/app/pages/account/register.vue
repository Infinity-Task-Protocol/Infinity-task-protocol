<script setup lang="ts">
import { ref } from 'vue'


definePageMeta({
  middleware: [
    'auth',
  ],
});

const session = useSessionStore()

const form = ref({
  name: '',

})


async function handleSubmit() {

  const payload = {
    name: form.value.name,

  }

  await session.backend.signUp(payload)

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
                <h5 class="text-lg font-semibold">Register</h5>

                <div>
                  <label class="font-semibold">Title:</label>
                  <input v-model="form.name" type="text" class="form-input mt-1 border" placeholder="name" />
                </div>


                <div class="pt-4">
                  <button type="submit" class="py-2 px-4 font-semibold text-white bg-emerald-600 rounded-md hover:bg-emerald-700 transition">
                    Register
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
