<script setup lang="ts">
interface Props {
  class?: string
  qty?: number
}

const props = defineProps<Props>()
const emit = defineEmits(["click"])
</script>

<template>
  <div
    class="relative w-9 h-8 ml-4"
    :class="props.class"
    @click="emit('click')"
  >
    <!-- El slot recibe el SVG del ícono -->
    <slot />

    <!-- Badge de cantidad -->
    <div
      v-if="props.qty && props.qty > 0"
      class="absolute top-6 right-0 bg-red-600 text-white text-xs font-bold min-w-4 h-4 p-[2px] flex items-center justify-center rounded-full"
    >
      {{ props.qty }}
    </div>
  </div>
</template>

