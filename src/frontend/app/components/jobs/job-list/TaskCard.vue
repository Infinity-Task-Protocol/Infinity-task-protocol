<template>
  <div class="group relative overflow-hidden bg-gradient-to-br from-white via-white to-gray-50/50 dark:from-slate-900 dark:via-slate-900 dark:to-slate-800/50 border border-gray-200/60 dark:border-slate-700/60 hover:border-emerald-200 dark:hover:border-emerald-800/50 shadow-sm hover:shadow-2xl hover:shadow-emerald-500/10 dark:shadow-gray-900/20 dark:hover:shadow-emerald-900/20 rounded-2xl transition-all duration-700 ease-out hover:-translate-y-2 hover:scale-[1.02] h-fit backdrop-blur-sm">

    <!-- Gradient overlay on hover -->
    <div class="absolute inset-0 bg-gradient-to-br from-emerald-500/5 to-blue-500/5 opacity-0 group-hover:opacity-100 transition-opacity duration-700"></div>

    <!-- Status indicator -->
    <div class="absolute top-3 right-3 z-10">
      <div class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
    </div>

    <div class="relative z-10 p-4">
      <!-- Header with enhanced design -->
      <div class="flex items-center gap-3 mb-3">
        <div class="relative">
          <div class="size-12 flex items-center justify-center bg-gradient-to-br from-emerald-400 to-emerald-600 shadow-lg shadow-emerald-500/25 dark:shadow-emerald-900/40 rounded-xl transform group-hover:rotate-6 transition-transform duration-500">
            <img :src="tokenImage" class="size-7 drop-shadow-sm" alt="Token" />
          </div>
        </div>

        <div class="flex-1 min-w-0">
          <NuxtLink
              :to="`/tasks/details/${id}`"
              class="block group/title"
          >
            <h3 class="text-base font-bold text-gray-900 dark:text-white mb-1 line-clamp-1 group-hover/title:text-emerald-600 dark:group-hover/title:text-emerald-400 transition-colors duration-300">
              {{ title }}
            </h3>
          </NuxtLink>

          <div class="text-xs text-gray-500 dark:text-gray-400">
            <code class="bg-gray-100 dark:bg-slate-800 px-1.5 py-0.5 rounded font-mono text-emerald-600 dark:text-emerald-400">
              {{ shortOwner }}
            </code>
          </div>
        </div>
      </div>

      <!-- Description -->
      <p class="text-sm text-gray-600 dark:text-gray-300 leading-relaxed mb-3 line-clamp-2">
        {{ description }}
      </p>

      <!-- Compact info row -->
      <div class="flex items-center justify-between text-xs mb-3">
        <div class="flex items-center gap-3">
          <div class="flex items-center gap-1 text-emerald-600 dark:text-emerald-400 font-semibold">
            <span>💰</span>
            <span>{{ rewardRange[0] }}-{{ rewardRange[1] }} {{ token.symbol }}</span>
          </div>
          <div class="flex items-center gap-1 text-blue-600 dark:text-blue-400 font-semibold">
            <span>📊</span>
            <span>{{ bidsCounter }} bids</span>
          </div>
        </div>
        <span class="text-gray-500">{{ formattedDate }}</span>
      </div>

      <!-- Tags -->
      <div class="flex flex-wrap gap-1.5 mb-3">
        <span
            v-for="(tag, index) in keywords.slice(0, 3)"
            :key="tag"
            class="inline-flex items-center gap-1 bg-gray-100 dark:bg-slate-800 text-gray-700 dark:text-gray-300 text-xs px-2 py-1 font-medium rounded-full hover:bg-emerald-100 dark:hover:bg-emerald-900/30 hover:text-emerald-700 dark:hover:text-emerald-400 transition-all duration-300 cursor-default"
        >
          <div class="w-1 h-1 bg-current rounded-full opacity-60"></div>
          {{ tag }}
        </span>
        <span
            v-if="keywords.length > 3"
            class="inline-flex items-center text-gray-400 dark:text-gray-500 text-xs px-2 py-1 font-medium"
        >
          +{{ keywords.length - 3 }}
        </span>
      </div>
    </div>

    <!-- Compact footer -->
    <div class="relative z-10 px-4 py-3 bg-gradient-to-r from-gray-50/80 to-white/80 dark:from-slate-800/80 dark:to-slate-700/50 border-t border-gray-100/80 dark:border-slate-700/50 backdrop-blur-sm">
      <div class="flex items-center justify-between">
        <div class="bg-emerald-500/10 dark:bg-emerald-500/20 text-emerald-600 dark:text-emerald-400 px-2.5 py-1 rounded-full text-xs font-bold backdrop-blur-sm border border-emerald-200/30 dark:border-emerald-700/30 flex items-center gap-1.5">
          <div class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></div>
          {{ status }}
        </div>

        <NuxtLink
            :to="`/tasks/details/${id}`"
            class="group/btn relative overflow-hidden bg-gradient-to-r from-emerald-600 to-emerald-700 hover:from-emerald-500 hover:to-emerald-600 text-white px-4 py-2 rounded-lg font-semibold text-sm shadow-lg shadow-emerald-500/25 hover:shadow-emerald-500/40 transform hover:-translate-y-0.5 transition-all duration-300"
        >
          <span class="relative z-10">View Details</span>
          <div class="absolute inset-0 bg-gradient-to-r from-emerald-400 to-emerald-500 opacity-0 group-hover/btn:opacity-100 transition-opacity duration-300"></div>
        </NuxtLink>
      </div>
    </div>

    <!-- Animated background elements -->
    <div class="absolute top-0 left-0 w-32 h-32 bg-gradient-to-br from-emerald-500/10 to-transparent rounded-full -translate-x-16 -translate-y-16 group-hover:scale-150 transition-transform duration-1000"></div>
    <div class="absolute bottom-0 right-0 w-24 h-24 bg-gradient-to-tl from-blue-500/10 to-transparent rounded-full translate-x-12 translate-y-12 group-hover:scale-150 transition-transform duration-1000 delay-150"></div>
  </div>
</template>

<script setup lang="ts">
import { Principal } from "@dfinity/principal"
import icon from "@/assets/images/icon-green.png"

const props = defineProps<{
  id: number
  owner: Principal
  status: string
  title: string
  description: string
  keywords: string[]
  rewardRange: [number, number]
  token: { symbol: string; image?: string }
  createdAt: number
  bidsCounter: number
}>()

const shortOwner = computed(() => {
  const text = props.owner.toText()
  return text.slice(0, 5) + "..." + text.slice(-4)
})

const formattedDate = computed(() =>
    new Date(Number(props.createdAt) / 1_000_000).toLocaleDateString()
)

const tokenImage = computed(() =>
    props.token.image || icon
)
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>