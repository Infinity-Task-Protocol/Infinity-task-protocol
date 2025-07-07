<template>
    <div v-if="related" class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Related Vacancies</h3>
        <p class="text-slate-400 dark:text-slate-300 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div v-else class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Jobs</h3>
        <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div v-if="jobs" class="grid lg:grid-cols-3 md:grid-cols-2 mt-8 gap-[30px]">

        <div v-for="item in datas.slice(0, 3)" :key="item" class="group shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 rounded-md bg-white dark:bg-slate-900">
            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                        <img :src="item.image" class="size-8" alt="">
                    </div>

                    <div class="ms-3">
                        <router-link to="/employer-detail" class="block text-[16px] font-semibold hover:text-emerald-600 transition-all duration-500">{{item.name }}</router-link>
                        <span class="block text-sm text-slate-400">{{ item.day }}</span>
                    </div>
                </div>

                <span class="bg-emerald-600/10 group-hover:bg-emerald-600 inline-block text-emerald-600 group-hover:text-white text-xs px-2.5 py-0.5 font-semibold rounded-full transition-all duration-500">{{item.type }}</span>
            </div>

            <div class="mt-6">
                <router-link to="/job-detail-one" class="text-lg hover:text-emerald-600 font-semibold transition-all duration-500">{{item.job }}</router-link>
                <h6 class="text-base font-medium"><i class="uil uil-map-marker"></i> {{ item.country }}</h6>
            </div>

            <div class="mt-6">
                <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                    <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 55%"></div>
                </div>
                <div class="mt-2">
                    <span class="text-slate-400 text-sm"><span class="text-slate-900 dark:text-white font-semibold inline-block">{{ item.vacancy }}</span>{{ item.vacancy2 }}</span>
                </div>
            </div>
        </div>
    </div>

    <div v-else class="grid lg:grid-cols-3 md:grid-cols-2 mt-8 gap-[30px]">

        <div v-for="item in datas" :key="item" class="group shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 rounded-md bg-white dark:bg-slate-900">
            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                        <img :src="item.image" class="size-8" alt="">
                    </div>

                    <div class="ms-3">
                        <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="block text-[16px] font-semibold hover:text-emerald-600 transition-all duration-500">{{item.name }}</router-link>
                        <span class="block text-sm text-slate-400">{{ item.day }}</span>
                    </div>
                </div>

                <span class="bg-emerald-600/10 group-hover:bg-emerald-600 inline-block text-emerald-600 group-hover:text-white text-xs px-2.5 py-0.5 font-semibold rounded-full transition-all duration-500">{{item.type }}</span>
            </div>

            <div class="mt-6">
                <router-link :to="{name: 'job-detail-two', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold transition-all duration-500">{{ item.job}}</router-link>
                <h6 class="text-base font-medium"><i class="uil uil-map-marker"></i> {{ item.country }}</h6>
            </div>

            <div class="mt-6">
                <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                    <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 55%"></div>
                </div>
                <div class="mt-2">
                    <span class="text-slate-400 text-sm"><span class="text-slate-900 dark:text-white font-semibold inline-block">{{ item.vacancy }}</span>{{ item.vacancy2 }}</span>
                </div>
            </div>
        </div>
    </div>

    <div v-if="seemore" class="grid md:grid-cols-12 grid-cols-1 mt-8">
        <div class="md:col-span-12 text-center">
            <router-link to="job-grid-two" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Jobs <i class="uil uil-arrow-right align-middle"></i></router-link>
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

defineProps({
    jobs:Boolean,
    related:Boolean,
    seemore:Boolean,
})

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
]

</script>

<style lang="scss" scoped></style>