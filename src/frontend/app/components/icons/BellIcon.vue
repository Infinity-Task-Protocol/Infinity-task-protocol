<script setup lang="ts">
import BaseIcon from "../BaseIcon.vue"

interface Props {
  class?: string
  qty?: number
}
const props = defineProps<Props>()
const emit = defineEmits(["click"])
</script>

<template>
  <BaseIcon :class="props.class" :qty="props.qty" @click="emit('click')">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 28"
      class="w-9 h-9 text-gray-700 cursor-pointer fill-[#dedede]"
    >
      <path
        d="M12 2C10.343 2 9 3.343 9 5v1.068C6.165 7.2 4.5 9.828 4.5 13v3l-1.5 1.5v1h18v-1L19.5 16v-3c0-3.172-1.665-5.8-4.5-6.932V5c0-1.657-1.343-3-3-3zm0 20c1.104 0 2-.896 2-2h-4c0 1.104.896 2 2 2z"
      />
    </svg>
  </BaseIcon>
</template>
