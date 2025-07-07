<template>
    <div class="container md:mt-24 mt-16">
        <div v-if="related" class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Related Blogs</h3>
            <p class="text-slate-400 dark:text-slate-300 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div v-else class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Latest Blog or News</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">

            <div v-for="item in datas" :key="item" class="group relative overflow-hidden bg-white dark:bg-slate-900 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700">
                <div class="relative overflow-hidden">
                    <img :src="item.image" class="scale-110 group-hover:scale-100 transition-all duration-500" alt="">
                </div>

                <div class="relative p-6">
                    <div class="absolute start-6 -top-4">
                        <span class="bg-emerald-600 text-white text-[12px] px-2.5 py-1 font-semibold rounded-full h-5">{{item.name }}</span>
                    </div>

                    <div class="">
                        <div class="flex mb-4">
                            <span class="text-slate-400 text-sm"><i class="uil uil-calendar-alt text-slate-900 dark:text-white me-2"></i>{{ item.date}}</span>
                            <span class="text-slate-400 text-sm ms-3"><i class="uil uil-clock text-slate-900 dark:text-white me-2"></i>{{ item.time }}</span>
                        </div>

                        <router-link :to="{ name: 'blog-detail', params: { id: item.id}}" class="title text-lg font-semibold hover:text-emerald-600 duration-500 ease-in-out">{{item.title }}</router-link>

                        <div class="flex justify-between items-center mt-3">
                            <router-link :to="{ name: 'blog-detail', params: { id: item.id}}" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative p-0 border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">Read More <i class="uil uil-arrow-right"></i></router-link>
                            <span class="text-slate-400 text-sm">by <router-link to="#" class="text-slate-900 dark:text-white hover:text-emerald-600 dark:hover:text-emerald-600 font-medium">{{ item.company}}</router-link></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>

<script setup>
import {defineProps} from 'vue'
import blog1 from '@/assets/images/blog/01.jpg'
import blog2 from '@/assets/images/blog/02.jpg'
import blog3 from '@/assets/images/blog/03.jpg'
defineProps({
    related:Boolean
})

const datas = [
    {
        id: 1,
        image: blog1,
        name: 'Arts',
        date: '20th February, 2023',
        time: '5 min read',
        title: '11 Tips to Help You Get New Clients Through Cold Calling',
        company: 'Google'
    },
    {
        id: 2,
        image: blog2,
        name: 'Illustration',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'DigitalOcean launches first Canadian data centre in Toronto',
        company: 'Facebook'
    },
    {
        id: 3,
        image: blog3,
        name: 'Music',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'Using Banner Stands To Increase Trade Show Traffic',
        company: 'Linkedin'
    },
]
</script>

<style lang="scss" scoped></style>