<script setup lang="ts">
import logo5 from '@/assets/images/company/spotify.png'
const session = useSessionStore()
const updatedTasks = ref<any[]>([])
const loading = ref(true)

onMounted(async () => {
  try {
    const tasks = await session.backend.getPaginateTaskPreview({
      page: BigInt(0),
      qtyPerPage: [BigInt(50)]
    })
    updatedTasks.value = tasks.arr.map((task, i) => ({
      ...task,
      id: task.id.toString(),
      name: tasks.arr[i]?.title,
      image: logo5,
      salary: `${tasks.arr[i]?.rewardRange[0]} to ${tasks.arr[i]?.rewardRange[1]} USDC`,
      day: "2 days ago",
      type: "Full Time",
      time: "1 to 3 months",
      language: tasks.arr[i]?.keywords,
      location: "Argentina"
    }))
  } catch (error) {
    console.error('Error al llamar el método de Motoko:', error)
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <section class="relative table w-full py-36 bg-[url('../../assets/images/hero/bg.jpg')] bg-top bg-no-repeat bg-cover">
    <div class="absolute inset-0 bg-emerald-900/90"></div>
    <div class="container">
      <div class="grid grid-cols-1 text-center mt-10">
        <h3 class="md:text-3xl text-2xl font-medium text-white">Job Vacancies</h3>
      </div>
    </div>

    <div class="absolute text-center z-10 bottom-5 start-0 end-0 mx-3">
      <ul class="breadcrumb tracking-[0.5px] breadcrumb-light mb-0 inline-block">
        <li class="inline breadcrumb-item text-[15px] font-semibold text-white/50 hover:text-white">
          <router-link to="/">Jobstack</router-link>
        </li>
        <li class="inline breadcrumb-item text-[15px] font-semibold text-white" aria-current="page">Job Listing</li>
      </ul>
    </div>
  </section>

  <div class="relative">
    <div class="shape absolute start-0 end-0 sm:-bottom-px -bottom-[2px] overflow-hidden z-1 text-white dark:text-slate-900">
      <svg class="w-full h-auto" viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 48H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor" />
      </svg>
    </div>
  </div>

  <section class="relative md:py-24 py-16">
    <div class="container">
      <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px]">
        <JobsSideBar />

        <div class="lg:col-span-8 md:col-span-6">
          <!-- Skeletons -->
          <div v-if="loading" class="grid grid-cols-1 gap-[30px]">
            <TaskSkeletonCard v-for="n in 5" :key="n" />
          </div>

          <!-- Cards -->
          <div v-else-if="updatedTasks.length" class="grid grid-cols-1 gap-[30px]">
            <JobsJobListTaskCard
                v-for="item in updatedTasks"
                :key="item.id"
                v-bind="item"
            />
          </div>

          <!-- Placeholder sin datos -->
          <div v-else class="text-center py-16 text-gray-500 dark:text-gray-400">
            <h2 class="text-xl font-semibold">No hay tareas disponibles</h2>
            <p class="text-sm mt-2">Vuelve más tarde o intenta con otros filtros.</p>
          </div>

          <Pagination />
        </div>
      </div>
    </div>
  </section>
</template>
