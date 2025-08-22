<script setup lang="ts">
import { useRouter } from 'vue-router'

const showLoader = ref(false)
const router = useRouter()

router.beforeEach((to, from, next) => {
  showLoader.value = true
  next()
})

router.afterEach(() => {
  setTimeout(() => {
    showLoader.value = false
  }, 500)
})
</script>

<template>
  <UApp>
  <NuxtLayout>
    <PageLoader :show="showLoader" />

      <NuxtPage />

  </NuxtLayout>
  </UApp>
</template>

