<template>
    
        <div class="grid md:grid-cols-12 grid-cols-1 items-center gap-[30px]">
            <div class="lg:col-span-5 md:col-span-6">
                <div class="relative">
                    <div class="relative">
                        <img :src="about1" class="lg:w-[400px] w-[280px] rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                        <div class="absolute top-0 translate-y-2/4 end-0 text-center">
                            <router-link to="#" @click="toggle" data-type="youtube" data-id="S_CGed6E610" class="lightbox size-20 rounded-full shadow-lg shadow-gray-200 dark:shadow-gray-700 inline-flex items-center justify-center bg-white dark:bg-slate-900 text-emerald-600 dark:text-white cursor-pointer">
                                <i class="mdi mdi-play inline-flex items-center justify-center text-2xl"></i>
                            </router-link>
                        </div>
                    </div>
                    <div class="absolute md:-end-5 end-0 -bottom-16">
                        <img :src="about2" class="lg:w-[280px] w-[200px] border-8 border-white dark:border-slate-900 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                    </div>
                </div>
            </div>

            <div class="lg:col-span-7 md:col-span-6 mt-14 md:mt-0">
                <div class="lg:ms-5">
                    <h3 class="mb-6 md:text-[26px] text-2xl md:leading-normal leading-normal font-semibold">Millions of jobs. <br> Find the one that's right for you.</h3>

                    <p class="text-slate-400 max-w-xl">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>

                    <ul class="list-none text-slate-400 mt-4">
                        <li class="mb-1 flex"><i class="uil uil-check-circle text-emerald-600 text-xl me-2"></i> Digital Marketing Solutions for Tomorrow</li>
                        <li class="mb-1 flex"><i class="uil uil-check-circle text-emerald-600 text-xl me-2"></i> Our Talented & Experienced Marketing Agency</li>
                        <li class="mb-1 flex"><i class="uil uil-check-circle text-emerald-600 text-xl me-2"></i> Create your own skin to match your brand</li>
                    </ul>

                    <div class="mt-6">
                        <router-link to="/contact" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white mt-2 rounded-md"><i class="uil uil-envelope"></i> Contact us</router-link>
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
</template>

<script setup>

import { ref } from 'vue'
import about1 from '@/assets/images/about/ab01.jpg'
import about2 from '@/assets/images/about/ab02.jpg'

const isActive = ref(false)

const toggle = () =>{
    isActive.value = !isActive.value
}

</script>

<style lang="scss" scoped></style>