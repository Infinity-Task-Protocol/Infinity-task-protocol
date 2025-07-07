<template>
    <div class="grid md:grid-cols-12 grid-cols-1 pb-8 items-end">
        <div class="lg:col-span-8 md:col-span-6">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Trending Services</h3>
            <p class="text-slate-400 max-w-xl">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>
    </div>

    <div class="grid grid-cols-1 mt-7 relative">
        <div class="tiny-five-item">
            <div v-for="item in datas" :key="item" class="tiny-slide">
                <div
                    class="group relative overflow-hidden rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 transition duration-500 m-1">
                    <img :src="item.image" alt="">
                    <div class="absolute inset-0 bg-slate-900/50"></div>

                    <div class="absolute bottom-0 p-4">
                        <router-link to="#" class="text-lg font-semibold text-white hover:text-emerald-600 transition-all duration-500">{{item.name}}</router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { tns } from 'tiny-slider/src/tiny-slider';
import { onMounted } from 'vue';
import work1 from '@/assets/images/work/01.jpg'
import work2 from '@/assets/images/work/02.jpg'
import work3 from '@/assets/images/work/03.jpg'
import work4 from '@/assets/images/work/04.jpg'
import work5 from '@/assets/images/work/05.jpg'
import work6 from '@/assets/images/work/06.jpg'

const  datas = [
    {
        image: work1,
        name: 'Product & Branding Design'
    },
    {
        image: work2,
        name: 'Wordpress Development'
    },
    {
        image: work3,
        name: 'Audio & Video Editing'
    },
    {
        image: work4,
        name: 'Admin & Customer Support'
    },
    {
        image: work5,
        name: 'UX / UI Designer'
    },
    {
        image: work6,
        name: 'Digital Marketing'
    },
]

onMounted(()=>{
    tns({
        container: '.tiny-five-item',
        controls: true,
        mouseDrag: true,
        loop: true,
        rewind: true,
        autoplay: true,
        autoplayButtonOutput: false,
        autoplayTimeout: 3000,
        navPosition: "bottom",
        controlsText: ['<i class="mdi mdi-chevron-left "></i>', '<i class="mdi mdi-chevron-right"></i>'],
        nav: false,
        speed: 400,
        gutter: 0,
        responsive: {
            1025: {
                items: 5
            },

            992: {
                items: 4
            },

            767: {
                items: 3
            },

            425: {
                items: 1
            },
        },
    });
})
</script>

<style lang="scss" scoped></style>