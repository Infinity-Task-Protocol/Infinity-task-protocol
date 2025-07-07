<template>
    <div class="container md:mt-24 md:pb-16 mt-16">
        <div class="grid md:grid-cols-12 grid-cols-1 items-center gap-[30px]">
            <div class="lg:col-span-5 md:col-span-6">
                <div class="relative">
                    <div class="relative">
                        <img :src="about1" class="lg:w-[400px] w-[280px] rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                        <div class="absolute top-0 translate-y-2/4 end-0 text-center">
                            <router-link to="#" @click="toggle" data-type="youtube" data-id="S_CGed6E610" class="lightbox size-20 rounded-full shadow-lg shadow-gray-200  dark:shadow-gray-700 inline-flex items-center justify-center bg-white dark:bg-slate-900 text-emerald-600 dark:text-white cursor-pointer">
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
                    <h3 class="mb-6 md:text-[26px] text-2xl md:leading-normal leading-normal font-semibold">Frequently Asked Questions</h3>

                    <p class="text-slate-400 max-w-xl">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>

                    <div v-for="item in datas" :key="item" id="accordion-collapseone" data-accordion="collapse" class="mt-4 first:m-0">
                        <div class="relative shadow-sm dark:shadow-gray-800 rounded-md overflow-hidden">
                            <h2 class="text-base font-semibold" id="accordion-collapse-heading-1">
                                <button @click="activeId = activeId === item.id ? null : item.id"  :class="item.id === activeId ? 'bg-gray-50 dark:bg-slate-800 text-emerald-600' : ''" type="button" class="flex justify-between items-center p-5 w-full font-semibold text-start" data-accordion-target="#accordion-collapse-body-1" aria-expanded="true" aria-controls="accordion-collapse-body-1">
                                    <span>{{item.name}}</span>
                                    <svg :class="item.id === activeId ? 'rotate-180' : ''" data-accordion-icon class="size-4 shrink-0" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                    </svg>
                                </button>
                            </h2>
                            <div :class="item.id === activeId ? '' : 'hidden'" id="accordion-collapse-body-1"  aria-labelledby="accordion-collapse-heading-1">
                                <div class="p-5">
                                    <p class="text-slate-400 dark:text-gray-400">{{item.title }}</p>
                                </div>
                            </div>
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
</template>

<script setup>
import {ref} from 'vue'
import about1 from '@/assets/images/about/ab01.jpg'
import about2 from '@/assets/images/about/ab02.jpg'

const activeId = ref(1)
const isActive = ref(false)

const toggle = () => {
    isActive.value = !isActive.value
}

const datas = [
    {
        id: 1,
        name: 'How does it work ?',
        title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
    },
    {
        id: 2,
        name: 'Do I need a designer to use Jobstack ?',
        title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
    },
    {
        id: 3,
        name: 'What do I need to do to start selling ?',
        title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
    },
]
</script>

<style lang="scss" scoped>

</style>