<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick, watch } from 'vue'

import { initFlowbite } from 'flowbite'
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

// 📦 DOM refs
const dropdownToggle = ref<HTMLElement | null>(null)


const handleScroll = () => {
  const navbar = document.getElementById("topnav")
  if (!navbar) return
  const scrollY = window.scrollY || document.documentElement.scrollTop
  navbar.classList.toggle("nav-sticky", scrollY >= 50)
}

const handleClickOutside = (event: MouseEvent) => {
  if (dropdownToggle.value && !dropdownToggle.value.contains(event.target as Node)) {
    dropdownOpen.value = false
  }
}

const scrollToTop = () => {
  window.scrollTo({top: 0, behavior: "smooth"})
}



// 🎯 Hooks
onMounted(() => {

  activeMenu.value = window.location.pathname
  window.addEventListener('scroll', handleScroll)
  document.addEventListener('click', handleClickOutside)

  scrollToTop()

})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.removeEventListener('click', handleClickOutside)
  console.log(session.isAuthenticated)
})

watchEffect(async () => {
  if (session.isAuthenticated) {
    console.log("authenticated")
    await nextTick()
    initFlowbite()
  }
})

</script>


<template>
  <nav class="bg-white dark:bg-gray-900 fixed w-full z-20 top-0 start-0 border-b border-gray-200 dark:border-gray-600">
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
      <NuxtLink to="/" class="flex items-center space-x-3 rtl:space-x-reverse">
        <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Infinity Tasks</span>
      </NuxtLink>
      <div v-if="!session.isAuthenticated" class="flex items-center md:order-2 space-x-1 md:space-x-0 rtl:space-x-reverse">
        <button type="button" data-modal-target="crypto-modal" data-modal-toggle="crypto-modal"
                class="text-gray-900 bg-white hover:bg-gray-100 border border-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-gray-600 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700">
          <svg aria-hidden="true" class="w-4 h-4 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
               xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"></path>
          </svg>
          Connect wallet
        </button>
      </div>
      <div v-else class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
        <button type="button"
                class="flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                id="user-menu-button" aria-expanded="false" data-dropdown-toggle="user-dropdown"
                data-dropdown-placement="bottom">
          <span class="sr-only">Open user menu</span>
          <img class="w-8 h-8 rounded-full" src="https://avatar.iran.liara.run/public/21" alt="user photo">
        </button>
        <!-- Dropdown menu -->
        <div
            class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow-sm dark:bg-gray-700 dark:divide-gray-600"
            id="user-dropdown">
          <div class="px-4 py-3">
            <span class="block text-sm text-gray-900 dark:text-white">Bonnie Green</span>
            <span class="block text-sm  text-gray-500 truncate dark:text-gray-400">name@flowbite.com</span>
          </div>
          <ul class="py-2" aria-labelledby="user-menu-button">
            <li>
              <a href="#"
                 class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Dashboard</a>
            </li>
            <li>
              <a href="#"
                 class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Settings</a>
            </li>

            <li>
              <button @click="logout"
                 class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Sign
                out</button>
            </li>
          </ul>
        </div>
      </div>
      <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-sticky">
        <ul class="flex flex-col p-4 md:p-0 mt-4 font-medium border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
          <li>
            <NuxtLink to="/"
               class="block py-2 px-3 text-white bg-blue-700 rounded-sm md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500"
               aria-current="page">Home</NuxtLink>
          </li>
          <li>
            <NuxtLink to="tasks"
               class="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 md:dark:hover:text-blue-500 dark:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Tasks</NuxtLink>
          </li>
        </ul>
      </div>
    </div>
  </nav>


  <!-- Main modal -->
  <div id="crypto-modal" tabindex="-1" aria-hidden="true"
       class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative p-4 w-full max-w-md max-h-full">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow-sm dark:bg-gray-700">
        <!-- Modal header -->
        <div
            class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600 border-gray-200">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
            Connect wallet
          </h3>
          <button type="button"
                  class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm h-8 w-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                  data-modal-toggle="crypto-modal">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
            <span class="sr-only">Close modal</span>
          </button>
        </div>
        <!-- Modal body -->
        <div class="p-4 md:p-5">
          <p class="text-sm font-normal text-gray-500 dark:text-gray-400">Connect with one of our available wallet
            providers or create a new one.</p>
          <ul class="my-4 space-y-3">
            <li>
              <button @click="loginWith('ii')"
                      class="flex items-center p-3 text-base font-bold text-gray-900 rounded-lg bg-gray-50 hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white">
                <span class="flex-1 ms-3 whitespace-nowrap">Internet Identity</span>
              </button>
            </li>
            <li>
              <button @click="loginWith('nfid')"
                      class="flex items-center p-3 text-base font-bold text-gray-900 rounded-lg bg-gray-50 hover:bg-gray-100 group hover:shadow dark:bg-gray-600 dark:hover:bg-gray-500 dark:text-white">
                <span class="flex-1 ms-3 whitespace-nowrap">NFID</span>
              </button>
            </li>
          </ul>
          <div>
            <a href="#"
               class="inline-flex items-center text-xs font-normal text-gray-500 hover:underline dark:text-gray-400">
              <svg class="w-3 h-3 me-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                   viewBox="0 0 20 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M7.529 7.988a2.502 2.502 0 0 1 5 .191A2.441 2.441 0 0 1 10 10.582V12m-.01 3.008H10M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
              </svg>
              Why do I need to connect with my wallet?</a>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>


<style lang="scss" scoped></style>