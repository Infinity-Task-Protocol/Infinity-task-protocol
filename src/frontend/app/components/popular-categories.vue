<template>
<div class="container">
    <div class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Categories</h3>
        <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div class="grid lg:grid-cols-6 md:grid-cols-3 sm:grid-cols-2 grid-cols-2 mt-8 gap-4">
        <div v-for="item in datas" :key="item" class="group relative overflow-hidden rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 transition duration-500">
            <img :src="item.image" alt="">
            <div class="absolute inset-0 bg-slate-900/50"></div>

            <div class="absolute bottom-0 p-4">
                <router-link to="#" class="text-lg font-semibold text-white hover:text-emerald-600 transition-all duration-500">{{item.name}}</router-link>
            </div>
        </div>
    </div>
</div>
</template>

<script setup>
import work1 from '@/assets/images/work/01.jpg'
import work2 from '@/assets/images/work/02.jpg'
import work3 from '@/assets/images/work/03.jpg'
import work4 from '@/assets/images/work/04.jpg'
import work5 from '@/assets/images/work/05.jpg'
import work6 from '@/assets/images/work/06.jpg'

    const datas = [
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
</script>

<style lang="scss" scoped></style>