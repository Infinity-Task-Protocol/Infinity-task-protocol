<script setup lang="ts">
import { initFlowbite} from 'flowbite'

onMounted(()=>{
  if (process.client) {
    initFlowbite()
  }
})
</script>

<template>

  <NuxtLayout>
    <NuxtPage/>
  </NuxtLayout>

</template>

