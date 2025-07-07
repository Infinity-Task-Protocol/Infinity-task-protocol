<template>
    <div class="lg:col-span-8 md:col-span-6">
        <div class="grid lg:grid-cols-2 gap-[30px]">
            <div v-for="item in datas" :key="item" class="group shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 rounded-md bg-white dark:bg-slate-900">
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                            <img :src="item.image" class="size-8"  alt="">
                        </div>

                        <div class="ms-3">
                            <router-link :to="{name : 'employer-detail', params: {id: item.id}}" class="block text-[16px] font-semibold hover:text-emerald-600 transition-all duration-500">{{item.name}}</router-link>
                            <span class="block text-sm text-slate-400">{{item.day}}</span>
                        </div>
                    </div>

                    <span class="bg-emerald-600/10 group-hover:bg-emerald-600 inline-block text-emerald-600 group-hover:text-white text-xs px-2.5 py-0.5 font-semibold rounded-full transition-all duration-500">{{item.type}}</span>
                </div>

                <div class="mt-6">
                    <router-link :to="{name : 'job-detail-three', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold transition-all duration-500">{{ item.job }}</router-link>
                    <h6 class="text-base font-medium"><i class="uil uil-map-marker"></i> {{item.country}}</h6>
                </div>

                <div class="mt-6">
                    <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                        <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 55%"></div>
                    </div>
                    <div class="mt-2">
                        <span class="text-slate-400 text-sm"><span class="text-slate-900 dark:text-white font-semibold inline-block">{{item.vacancy}}</span> {{item.vacancy2}}</span>
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
        image: logo1,
        name: 'Facebook',
        day: '2 days ago',
        type: 'Full Time',
        job: 'Web Designer / Developer',
        country: 'Australia',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 2,
        image: logo2,
        name: 'Google',
        day: '2 days ago',
        type: 'Part Time',
        job: 'Marketing Director',
        country: 'USA',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 3,
        image: logo3,
        name: 'Android',
        day: '2 days ago',
        type: 'Remote',
        job: 'Application Developer',
        country: 'China',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 4,
        image: logo4,
        name: 'Lenovo',
        day: '2 days ago',
        type: 'WFH',
        job: 'Senior Product Designer',
        country: 'Dubai',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 5,
        image: logo5,
        name: 'Spotify',
        day: '2 days ago',
        type: 'Full Time',
        job: 'C++ Developer',
        country: 'India',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 6,
        image: logo6,
        name: 'Linkedin',
        day: '2 days ago',
        type: 'Remote',
        job: 'Php Developer',
        country: 'Pakistan',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 7,
        image: logo7,
        name: 'Circle CI',
        day: '2 days ago',
        type: 'Full Time',
        job: 'Web Designer / Developerr',
        country: 'Australia',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 8,
        image: logo8,
        name: 'Google',
        day: '2 days ago',
        type: 'Part Time',
        job: 'Marketing Director',
        country: 'USA',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 9,
        image: logo9,
        name: 'Android',
        day: '2 days ago',
        type: 'Remote',
        job: 'Application Developer',
        country: 'China',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 10,
        image: logo10,
        name: 'Lenovo',
        day: '2 days ago',
        type: 'WFH',
        job: 'Senior Product Designer',
        country: 'Dubai',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 11,
        image: logo11,
        name: 'Spotify',
        day: '2 days ago',
        type: 'Full Time',
        job: 'C++ Developer',
        country: 'India',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },
    {
        id: 12,
        image: logo12,
        name: 'Linkedin',
        day: '2 days ago',
        type: 'Remote',
        job: 'Php Developer',
        country: 'Pakistan',
        vacancy: '21 applied',
        vacancy2: 'of 40 vacancy'
    },               
    
]
</script>

<style lang="scss" scoped>

</style>