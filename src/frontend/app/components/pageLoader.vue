<template>
  <div
      v-show="show"
      class="fixed inset-0 flex items-center justify-center bg-black z-[9999]"
  >
    <div class="flex space-x-1">
      <span
          v-for="(letter, index) in letters"
          :key="index"
          class="text-4xl font-bold text-white animate-bounce"
          :style="{ animationDelay: `${index * 0.1}s` }"
      >
        {{ letter }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{ show: boolean }>()
const letters = ['I', 'n', 'f', 'i', 'n', 'i', 't', 'y', ' ', 'T', 'a', 's', 'k']
</script>

<style scoped>
@keyframes bounce {
  0%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
}
.animate-bounce {
  animation: bounce 1s infinite;
}
</style>
