<template>

    <div class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Categories</h3>
        <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div v-if="categories" class="grid lg:grid-cols-5 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
        <div v-for="item in datas" :key="item" class="group px-3 py-10 rounded-full shadow-sm shadow-gray-200 dark:shadow-gray-700 hover:shadow-emerald-600/10 dark:hover:shadow-emerald-600/10 text-center bg-white dark:bg-slate-900 hover:bg-emerald-600/5 dark:hover:bg-emerald-600/5 transition duration-500">
            <div class="size-16 bg-emerald-600/5 group-hover:bg-emerald-600 text-emerald-600 group-hover:text-white rounded-full text-2xl flex align-middle justify-center items-center shadow-xs shadow-gray-200 dark:shadow-gray-700 transition duration-500 mx-auto">
                <i :class="item.icon"></i>
            </div>

            <div class="content mt-6">
                <router-link to="" class="title text-lg font-semibold hover:text-emerald-600">{{item.title}} <br/> {{ item.title2 }}</router-link>
                <p class="text-slate-400 mt-3">{{item.job}}</p>
            </div>
        </div>
    </div>


    <div v-else class="grid lg:grid-cols-5 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
        <div v-for="item in datas" :key="item" class="group px-3 py-10 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 hover:shadow-emerald-600/10 dark:hover:shadow-emerald-600/10 text-center bg-white dark:bg-slate-900 hover:bg-emerald-600/5 dark:hover:bg-emerald-600/5 transition duration-500">
            <div class="size-16 bg-emerald-600/5 group-hover:bg-emerald-600 text-emerald-600 group-hover:text-white rounded-md text-2xl flex align-middle justify-center items-center shadow-xs shadow-gray-200 dark:shadow-gray-700 transition duration-500 mx-auto">
                <i :class="item.icon"></i>
            </div>

            <div class="content mt-6">
                <router-link to="#" class="title text-lg font-semibold hover:text-emerald-600">{{item.title}} <br/> {{ item.title2 }}</router-link>
                <p class="text-slate-400 mt-3">{{item.job}}</p>
            </div>
        </div>
    </div>
</template>

<script setup>
import {defineProps} from 'vue'

defineProps({
    categories:Boolean
})
const datas = [
    {
        icon: 'uil uil-gitlab',
        title: 'Business',
        title2: 'Development', 
        job: '74 Jobs'
    },
    {
        icon: 'uil uil-book-open',
        title: 'Marketing &',
        title2: 'Communication', 
        job: '20 Jobs'
    },
    {
        icon: 'uil uil-chart-pie-alt',
        title: 'Project',
        title2: 'Management', 
        job: '35 Jobs'
    },
    {
        icon: 'uil uil-feedback',
        title: 'Customer',
        title2: 'Service', 
        job: '46 Jobs'
    },
    {
        icon: 'uil uil-presentation-line',
        title: 'Software',
        title2: 'Engineering', 
        job: '60 Jobs'
    },
]

</script>

<style lang="scss" scoped></style>