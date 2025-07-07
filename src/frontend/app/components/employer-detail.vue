<template>

    <div v-if="jobs" class="container lg:mt-24 mt-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Related Companies</h3>
            <p class="text-slate-400 dark:text-slate-300 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-4 md:grid-cols-2 grid-cols-1 gap-[30px] mt-8">
            <div v-for="item in datas.slice(8, 12)" :key="item" class="group relative p-6 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 mt-6">
                <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-md shadow-gray-200  dark:shadow-gray-700 rounded-md relative -mt-12">
                    <img :src="item.image" class="size-8" alt="">
                </div>

                <div class="mt-4">
                    <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold">{{ item.name }}</router-link>
                    <p class="text-slate-400 mt-2">{{ item.title }}</p>
                </div>

                <div class="mt-4 pt-4 border-t border-gray-100 dark:border-gray-800 flex justify-between">
                    <span class="text-slate-400"><i class="uil uil-map-marker"></i> {{ item.location }}</span>
                    <span class="block font-semibold text-emerald-600">{{ item.job }}</span>
                </div>
            </div>
        </div>
    </div>


    <div v-else class="grid lg:grid-cols-4 md:grid-cols-2 grid-cols-1 gap-[30px]">
        <div v-for="item in datas" :key="item" class="group relative p-6 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 mt-6">
            <div
                class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-md shadow-gray-200 dark:shadow-gray-700 rounded-md relative -mt-12">
                <img :src="item.image" class="size-8" alt="">
            </div>

            <div class="mt-4">
                <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold">{{ item.name }}</router-link>
                <p class="text-slate-400 mt-2">{{ item.title }}</p>
            </div>

            <div class="mt-4 pt-4 border-t border-gray-100 dark:border-gray-800 flex justify-between">
                <span class="text-slate-400"><i class="uil uil-map-marker"></i> {{ item.location }}</span>
                <span class="block font-semibold text-emerald-600">{{ item.job }}</span>
            </div>
        </div>
    </div>

</template>

<script setup>
import {defineProps} from 'vue'

import logo1 from '@/assets/images/company/facebook-logo.png'
import logo2 from '@/assets/images/company/google-logo.png'
import logo3 from '@/assets/images/company/android.png'
import logo4 from '@/assets/images/company/lenovo-logo.png'
import logo5 from '@/assets/images/company/spotify.png'
import logo6 from '@/assets/images/company/linkedin.png'
import logo7 from '@/assets/images/company/circle-logo.png'
import logo8 from '@/assets/images/company/skype.png'
import logo9 from '@/assets/images/company/snapchat.png'
import logo10 from '@/assets/images/company/shree-logo.png'
import logo11 from '@/assets/images/company/telegram.png'
import logo12 from '@/assets/images/company/whatsapp.png'

defineProps({
    jobs:Boolean
})

const datas = [
    {
        id: 1,
        image: logo1,
        name: 'Facebook',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'USA',
        job: '6 Jobs'
    },
    {
        id: 2,
        image: logo2,
        name: 'Google',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'China',
        job: '6 Jobs'
    },
    {
        id: 3,
        image: logo3,
        name: 'Android',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Dubai',
        job: '6 Jobs'
    },
    {
        id: 4,
        image: logo4,
        name: 'Lenovo',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Pakistan',
        job: '6 Jobs'
    },
    {
        id: 5,
        image: logo5,
        name: 'Spotify',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Australia',
        job: '6 Jobs'
    }, 
    {
        id: 6,
        image: logo6,
        name: 'Linkedin',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'India',
        job: '6 Jobs'
    },                        
    {
        id: 7,
        image: logo7,
        name: 'Circle CI',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Pakistan',
        job: '6 Jobs'
    },
    {
        id: 8,
        image: logo8,
        name: 'Skype',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Rush',
        job: '6 Jobs'
    },
    {
        id: 9,
        image:logo9,
        name: 'Snapchat',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Turkey',
        job: '6 Jobs'
    },
    {
        id: 10,
        image: logo10,
        name: 'Shreethemes',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'India',
        job: '6 Jobs'
    },
    
    {
        id: 11,
        image: logo11,
        name: 'Telegram',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'India',
        job: '6 Jobs'
    },
    {
        id: 12,
        image: logo12,
        name: 'Whatsapp',
        title: 'Digital Marketing Solutions for Tomorrow',
        location: 'Rush',
        job: '6 Jobs'
    },
]

</script>

<style lang="scss" scoped></style>