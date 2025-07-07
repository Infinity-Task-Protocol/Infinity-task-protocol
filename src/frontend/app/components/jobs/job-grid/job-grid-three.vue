<template>
    <div class="container mt-10">
        <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-[30px]">
            <div v-for="item in datas" :key="item"
                class="group relative overflow-hidden rounded-md shadow-sm dark:shadow-gray-800">
                <div class="p-6">
                    <router-link :to="{ name: 'job-detail-two', params: { id: item.id } }" class="title h5 text-lg font-semibold hover:text-emerald-600">{{ item.job }}</router-link>
                    <p class="text-slate-400 mt-2"><i class="uil uil-clock text-emerald-600"></i> {{ item.day }}</p>

                    <div class="flex justify-between items-center mt-4">
                        <span class="bg-emerald-600/5 text-emerald-600 text-xs font-bold px-2.5 py-0.5 rounded h-5">{{item.type }}</span>
                        <p class="text-slate-400"><i class="uil uil-usd-circle text-emerald-600"></i> {{ item.salary }}</p>
                    </div>
                </div>

                <div class="flex items-center p-6 border-t border-gray-100 dark:border-gray-800">
                    <img :src="item.image" class="size-12 shadow-md dark:shadow-gray-800 rounded-md p-2 bg-white dark:bg-slate-900" alt="">

                    <div class="ms-3">
                        <h6 class="mb-0 font-semibold text-base">{{ item.name }}</h6>
                        <span class="text-slate-400 text-sm">{{ item.location }}</span>
                    </div>
                </div>
            </div>
        </div>
        <pagination />
    </div>

</template>

<script setup>
import Pagination from '~/components/Pagination.vue'

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


const datas = [
    {
        id: 1,
        job: 'Software Engineering',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$950 - $1100/mo',
        image: logo1,
        name: 'Facebook Ltd.',
        location: 'Australia'
    },
    {
        id: 2,
        job: 'Web Developer',
        day: 'Posted 3 Days ago',
        type: 'Remote',
        salary: '$2500 - $2600/mo',
        image: logo2,
        name: 'Google Ltd.',
        location: 'America'
    },
    {
        id: 3,
        job: 'UX/UI Designer',
        day: 'Posted 3 Days ago',
        type: 'Freelance',
        salary: '$3500 - $3600/mo',
        image: logo3,
        name: 'Linkedin Ltd.',
        location: 'Canada'
    },
    {
        id: 4,
        job: 'Human Resource(HR)',
        day: 'Posted 3 Days ago',
        type: 'Part Time',
        salary: '$2000 - $2500/mo',
        image: logo4,
        name: 'Skype Ltd.',
        location: 'UK'
    },
    {
        id: 5,
        job: 'Web Designer',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$1500 - $1600/mo',
        image: logo5,
        name: 'Spotify Ltd.',
        location: 'China'
    },
    {
        id: 6,
        job: 'Graphic Designer',
        day: 'Posted 3 Days ago',
        type: 'Part time',
        salary: '$500 - $600/mo',
        image: logo6,
        name: 'Telegram Ltd.',
        location: 'India'
    },
    {
        id: 7,
        job: 'Software Engineering',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$950 - $1100/mo',
        image: logo7,
        name: 'Circle CI Ltd.',
        location: 'Australia'
    },
    {
        id: 8,
        job: 'Web Developer',
        day: 'Posted 3 Days ago',
        type: 'Remote',
        salary: '$2500 - $2600/mo',
        image: logo8,
        name: 'Skype Ltd.',
        location: 'America'
    },
    {
        id: 9,
        job: 'UX/UI Designer',
        day: 'Posted 3 Days ago',
        type: 'Freelance',
        salary: '$3500 - $3600/mo',
        image: logo9,
        name: 'Snapchat Ltd.',
        location: 'Canada'
    },
    {
        id: 10,
        job: 'Human Resource(HR)',
        day: 'Posted 3 Days ago',
        type: 'Part Time',
        salary: '$2000 - $2500/mo',
        image: logo10,
        name: 'Shreethemes Ltd.',
        location: 'UK'
    },
    {
        id: 11,
        job: 'Web Designer',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$1500 - $1600/mo',
        image: logo11,
        name: 'Telegram Ltd.',
        location: 'China'
    },
    {
        id: 12,
        job: 'Graphic Designer',
        day: 'Posted 3 Days ago',
        type: 'Part time',
        salary: '$500 - $600/mo',
        image: logo12,
        name: 'Whatsapp Ltd.',
        location: 'India'
    },
]

</script>

<style lang="scss" scoped></style>