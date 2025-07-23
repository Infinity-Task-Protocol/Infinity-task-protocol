<script setup lang="ts">
import {ref, onMounted, onUnmounted} from 'vue'

// 🧩 Props
defineProps<{
  lightLogo: boolean
  lightNav: string
  container: string
}>()

// 🧠 State
const toggle = ref(false)
const activeMenu = ref('')
const menu = ref(true)
const menuOpen = ref('')
const dropdownOpen = ref(false)

// 🔗 Store y auth
const session = useSessionStore()
const {loginWith, logout} = useAuth()


const handleScroll = () => {
  const navbar = document.getElementById("topnav")
  if (!navbar) return
  const scrollY = window.scrollY || document.documentElement.scrollTop
  navbar.classList.toggle("nav-sticky", scrollY >= 50)
}



const scrollToTop = () => {
  window.scrollTo({top: 0, behavior: "smooth"})
}


// 🎯 Hooks
onMounted(() => {

  activeMenu.value = window.location.pathname
  window.addEventListener('scroll', handleScroll)

  scrollToTop()

})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

const isOpen = ref(false)

const dropdownItems = [
  [{label: 'Account', icon: 'i-heroicons-home', onSelect: () => navigateTo('/account')}],
  [{label: 'Settings', icon: 'i-heroicons-cog-6-tooth', onSelect: () => navigateTo('/account/settings')}],
  [{
    label: 'Sign out', icon: 'i-heroicons-arrow-left-on-rectangle', onSelect() {
      logout()
    }
  }],
]

</script>


<template>
  <nav class="bg-white dark:bg-gray-900 fixed w-full z-20 top-0 start-0 border-b border-gray-200 dark:border-gray-600">
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
      <NuxtLink to="/" class="flex items-center space-x-3 rtl:space-x-reverse">
        <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Infinity Tasks</span>
      </NuxtLink>

      <!-- Botón conectar -->
      <div v-if="!session?.isAuthenticated" class="flex items-center md:order-2 space-x-1">
        <UButton label="Connect Wallet" @click="isOpen = true" color="primary"/>
      </div>

      <!-- Avatar con dropdown -->
      <div v-else class="flex items-center md:order-2 space-x-3">
        <UDropdownMenu
            :items="dropdownItems"
            :modal="false"
            :popper="{ placement: 'bottom-start', offset: 8 }"
            :ui="{ content: 'w-44' }"
        >

          <template #default>
            <button
                class="dropdown-toggle items-center"
                type="button"
            >
              <span
                  class="size-9 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide border align-middle transition duration-500 ease-in-out rounded-full bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white">
                <img src="../../assets/images/team/01.jpg" class="rounded-full" alt="">
              </span>
            </button>
          </template>
        </UDropdownMenu>
      </div>

      <!-- Navbar Links -->
      <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-sticky">
        <ul class="flex flex-col p-4 md:p-0 mt-4 font-medium border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
          <li>
            <NuxtLink
                to="/"
                class="block py-2 px-3 text-white bg-blue-700 rounded-sm md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500"
                aria-current="page"
            >Home
            </NuxtLink>
          </li>
          <li>
            <NuxtLink
                to="/tasks"
                class="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 md:dark:hover:text-blue-500 dark:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700"
            >Tasks
            </NuxtLink>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <UModal
      v-model:open="isOpen"
  >

    <template #content>

      <!-- Contenido del modal -->
      <div class="p-4 md:p-5">
        <p class="text-sm font-normal text-gray-500 dark:text-gray-400">
          Connect with one of our available wallet providers or create a new one.
        </p>

        <ul class="my-4 space-y-3">
          <li>
            <button
                @click="isOpen = false; loginWith('ii')"
                class="flex items-center p-3 text-base font-bold text-gray-900 rounded-lg bg-gray-50 hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white w-full"
            >
              <span class="flex-1 ms-3 whitespace-nowrap text-left">Internet Identity</span>
            </button>
          </li>
          <li>
            <button
                @click="isOpen = false; loginWith('nfid')"
                class=" flex items-center p-3 text-base font-bold text-gray-900 rounded-lg bg-gray-50 hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white w-full"
            >
              <span class="flex-1 ms-3 whitespace-nowrap text-left">NFID</span>
            </button>
          </li>
        </ul>
      </div>
    </template>
  </UModal>

</template>


<style lang="scss" scoped></style>