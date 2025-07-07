<template>
    <div class="container md:mt-24 mt-16">
        <div class="grid grid-cols-1">
            <div class="relative overflow-hidden bg-emerald-600 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700">
                <div class="grid md:grid-cols-2 items-center gap-[30px]">
                    <div class="relative">
                        <img :src="about" alt="">
                        <div class="absolute md:bottom-1/2 md:translate-y-1/2 md:-end-10 ltr:md:translate-x-0 rtl:md:translate-x-0 -bottom-10 end-1/2 ltr:translate-x-1/2 rtl:-translate-x-1/2 text-center">
                            <router-link to="#" @click="toggle" data-type="youtube" data-id="S_CGed6E610" class="lightbox size-20 rounded-full shadow-lg shadow-gray-200 dark:shadow-gray-700 inline-flex items-center justify-center bg-white dark:bg-slate-900 text-emerald-600 dark:text-white cursor-pointer">
                                <i class="mdi mdi-play inline-flex items-center justify-center text-2xl"></i>
                            </router-link>
                        </div>
                    </div>

                    <div>
                        <div class="text-white p-4">
                            <h4 class="leading-normal text-4xl mb-3 font-semibold">Get the job of your <br> dreams quickly.</h4>

                            <p class="text-white/70 text-lg max-w-xl">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>

                            <ul class="list-none text-white/50 mt-4">
                                <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> Digital Marketing Solutions for Tomorrow</li>
                                <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> Our Talented & Experienced Marketing Agency</li>
                                <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i>Create your own skin to match your brand</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div :class="isActive ? 'fixed' : 'hidden'" class="bg-black/[0.9] top-0 left-0 bottom-0 w-[100%] h-[100%] z-999">
        <div class="h-[100%] flex items-center justify-center">
            <iframe src="https://www.youtube.com/embed/S_CGed6E610?feature=oembed" width="700" height="500" frameborder="0"></iframe>
        </div><button class="text-slate-400 absolute top-[20px] right-[20px]">
            <svg stroke="currentColor" fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" class="size-5" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg" @click="toggle">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
        </button>
    </div>

    <div class="md:my-24 my-16">
        <counter />
    </div>
</template>

<script setup>
import counter from '@/components/counter.vue'
import about from '@/assets/images/about/ab05.jpg'

import { ref } from 'vue'

const isActive = ref(false)

const toggle = () => {
    isActive.value = !isActive.value
}
</script>

<style lang="scss" scoped></style>