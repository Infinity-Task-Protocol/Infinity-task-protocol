<template>
    <div class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Find Best Companies</h3>
        <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div class="grid lg:grid-cols-4 md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">

        <div v-for="item in datas" :key="item" class="group relative p-6 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 mt-6">
            <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-md shadow-gray-200 dark:shadow-gray-700 rounded-md relative -mt-12">
                <img :src="item.image" class="size-8" alt="">
            </div>

            <div class="mt-4">
                <router-link :to="{ name: 'employer-detail', params: { id: item.id } }" class="text-lg hover:text-emerald-600 font-semibold">{{ item.name }}</router-link>
                <p class="text-slate-400 mt-2">{{ item.desc }}</p>
            </div>

            <div class="mt-4 pt-4 border-t border-gray-100 dark:border-gray-800 flex justify-between">
                <span class="text-slate-400"><i class="uil uil-map-marker"></i> {{ item.country }}</span>
                <span class="block font-semibold text-emerald-600">{{ item.jobs }}</span>
            </div>
        </div>
    </div>

    <div class="grid md:grid-cols-12 grid-cols-1 mt-6">
        <div class="md:col-span-12 text-center">
            <router-link to="" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Companies <i class="uil uil-arrow-right align-middle"></i></router-link>
        </div>
    </div>
</template>

<script setup>
import logo1 from '@/assets/images/company/facebook-logo.png'
import logo2 from '@/assets/images/company/google-logo.png'
import logo3 from '@/assets/images/company/android.png'
import logo4 from '@/assets/images/company/lenovo-logo.png'
import logo5 from '@/assets/images/company/spotify.png'
import logo6 from '@/assets/images/company/linkedin.png'
import logo7 from '@/assets/images/company/circle-logo.png'
import logo8 from '@/assets/images/company/skype.png'

    const datas = [
        {
            id: 1,
            image: logo1,
            name: 'Facebook',
            country: 'USA',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 2,
            image: logo2,
            name: 'Google',
            country: 'China',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 3,
            image: logo3,
            name: 'Android',
            country: 'Dubai',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 4,
            image: logo4,
            name: 'Lenovo',
            country: 'Pakistan',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 5,
            image: logo5,
            name: 'Spotify',
            country: 'Australia',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },                           
        {
            id: 6,
            image: logo6,
            name: 'Linkedin',
            country: 'India',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 7,
            image: logo7,
            name: 'Circle CI',
            country: 'Rush',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
        {
            id: 8,
            image: logo8,
            name: 'skype',
            country: 'Turkey',
            desc: 'Digital Marketing Solutions for Tomorrow',
            jobs: '6 Jobs'
        },
    ]
</script>

<style lang="scss" scoped></style>