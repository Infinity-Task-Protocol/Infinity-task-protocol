<template>

    <div v-if="lists" class="container lg:mt-24 mt-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Related Candidates</h3>
            <p class="text-slate-400 dark:text-slate-300 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-4 md:grid-cols-2 grid-cols-1 gap-[30px] mt-8">
            <div v-for="item in datas.slice(0, 4)" :key="item" class="group bg-white dark:bg-slate-900 relative overflow-hidden rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 text-center p-6">
            <img :src="item.image" class="size-20 rounded-full shadow-sm shadow-gray-200 dark:shadow-gray-700 mx-auto" alt="">

            <div class="mt-2">
                <router-link :to="{name: 'candidate-profile', params: {id: item.id}}" class="hover:text-emerald-600 font-semibold text-lg">{{ item.name }}</router-link>
                <p class="text-sm text-slate-400">{{ item.position }}</p>
            </div>

            <ul class="mt-2 list-none">
                <li v-for="type in item.type" :key="type" class="inline me-1"><span class="bg-emerald-600/10 inline-block text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full">{{ type }}</span></li>
            </ul>

            <div class="flex justify-between mt-2">
                <div class="block">
                    <span class="text-slate-400">Salery:</span>
                    <span class="block text-sm font-semibold">{{ item.salary }}</span>
                </div>
                <div class="block">
                    <span class="text-slate-400">Experience:</span>
                    <span class="block text-sm font-semibold">{{ item.experience }}</span>
                </div>
            </div>

            <div class="mt-3">
                <router-link :to="{name: 'candidate-profile', params: {id: item.id}}" class="py-[5px] px-4 text-sm inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 dark:border-emerald-600 text-white rounded-md">Profile</router-link>
                <router-link to="#" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide border align-middle transition duration-500 ease-in-out bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white rounded-full ms-1"><i class="uil uil-hipchat text-[20px]"></i></router-link>
            </div>

            <span class="w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1"><i :class="item.class"></i></span>

            <span class="absolute top-[10px] end-4">
                <router-link to="#" class="text-slate-100 dark:text-slate-700 focus:text-red-600 dark:focus:text-red-600 hover:text-red-600 dark:hover:text-red-600 text-2xl"><i class="mdi mdi-heart"></i></router-link>
            </span>
        </div>
        </div>
    </div>


    <div v-else class="grid xl:grid-cols-4 lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-[30px]">
        <div v-for="item in datas" :key="item" class="group bg-white dark:bg-slate-900 relative overflow-hidden rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 text-center p-6">
            <img :src="item.image" class="size-20 rounded-full shadow-sm shadow-gray-200 dark:shadow-gray-700 mx-auto" alt="">

            <div class="mt-2">
                <router-link :to="{name: 'candidate-profile', params: {id: item.id}}" class="hover:text-emerald-600 font-semibold text-lg">{{ item.name }}</router-link>
                <p class="text-sm text-slate-400">{{ item.position }}</p>
            </div>

            <ul class="mt-2 list-none">
                <li v-for="type in item.type" :key="type" class="inline me-1"><span class="bg-emerald-600/10 inline-block text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full">{{ type }}</span></li>
            </ul>

            <div class="flex justify-between mt-2">
                <div class="block">
                    <span class="text-slate-400">Salery:</span>
                    <span class="block text-sm font-semibold">{{ item.salary }}</span>
                </div>
                <div class="block">
                    <span class="text-slate-400">Experience:</span>
                    <span class="block text-sm font-semibold">{{ item.experience }}</span>
                </div>
            </div>

            <div class="mt-3">
                <router-link :to="{name: 'candidate-profile', params: {id: item.id}}" class="py-[5px] px-4 text-sm inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 dark:border-emerald-600 text-white rounded-md">Profile</router-link>
                <router-link to="" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide border align-middle transition duration-500 ease-in-out bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white rounded-full ms-1"><i class="uil uil-hipchat text-[20px]"></i></router-link>
            </div>

            <span class="w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1"><i :class="item.class"></i></span>

            <span class="absolute top-[10px] end-4">
                <router-link to="#" class="text-slate-100 dark:text-slate-700 focus:text-red-600 dark:focus:text-red-600 hover:text-red-600 dark:hover:text-red-600 text-2xl"><i class="mdi mdi-heart"></i></router-link>
            </span>
        </div>
    </div>
</template>

<script setup>
import {defineProps} from 'vue'
import team1 from '@/assets/images/team/01.jpg'
import team2 from '@/assets/images/team/02.jpg'
import team3 from '@/assets/images/team/03.jpg'
import team4 from '@/assets/images/team/04.jpg'
import team5 from '@/assets/images/team/05.jpg'
import team6 from '@/assets/images/team/06.jpg'
import team7 from '@/assets/images/team/07.jpg'
import team8 from '@/assets/images/team/08.jpg'

    defineProps({
        lists:Boolean
    })
    const datas = [
        {
            id: 1,
            image: team1,
            name: 'Steven Townsend',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: 'uil uil-star'
        },
        {
            id: 2,
            image: team2,
            name: 'Tiffany Betancourt',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: ''
        },
        {
            id: 3,
            image: team3,
            name: 'Jacqueline Burns',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: ''
        },
        {
            id: 4,
            image: team4,
            name: 'Mari Harrington',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: ''
        },
        {
            id: 5,
            image: team5,
            name: 'Floyd Glasgow',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: ''
        },
        {
            id: 6,
            image: team6,
            name: 'Donna Schultz',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: ''
        },
        {
            id: 7,
            image: team7,
            name: 'Joshua Morris',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: 'uil uil-star'
        },
        {
            id: 8,
            image: team8,
            name: 'Rosaria Vargas',
            position: 'Web Designer',
            type: ['Design', 'UI', 'Digital'],
            salary: '$4k - $4.5k',
            experience: '2 Years',
            class: 'uil uil-star'
        },
    ]
</script>

<style lang="scss" scoped></style>