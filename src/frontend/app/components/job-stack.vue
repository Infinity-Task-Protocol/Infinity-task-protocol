<template>
     
    <div v-if="jobstack" class="container">
        <div v-if="features" class="grid grid-cols-1 pb-8 text-center mb-8">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Jobstack Features</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-4 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 gap-[30px]">
            <div v-for="item in datas" :key="item" class="group p-6 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md bg-white hover:bg-emerald-600/5 dark:bg-slate-900 dark:hover:bg-emerald-600/10 text-center transition-all duration-500">
                <div class="size-16 flex items-center justify-center mx-auto bg-emerald-600/5 group-hover:bg-emerald-600 dark:bg-emerald-600/10 dark:group-hover:bg-emerald-600 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-lg transition-all duration-500">
                    <i :class="item.icon" class="text-[30px] text-emerald-600 group-hover:text-white"></i>
                </div>

                <div class="mt-4">
                    <router-link to="#" class="text-lg font-semibold hover:text-emerald-600 transition-all duration-500">{{ item.name }}</router-link>
                    <p class="text-slate-400 mt-3 mb-2">{{ item.desc }}</p>
                    <router-link to="#" class="hover:text-emerald-600 font-medium transition-all duration-500">Read More <i class="uil uil-arrow-right"></i></router-link>
                </div>
            </div>

        </div>
    </div>


    <div v-else class="container md:mt-24 mt-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Here's why you'll love it Jobstack</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-4 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
            <div v-for="item in datas.slice(0, 4)" :key="item"
                class="group p-6 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md bg-white hover:bg-emerald-600/5 dark:bg-slate-900 dark:hover:bg-emerald-600/10 text-center transition-all duration-500">
                <div class="size-16 flex items-center justify-center mx-auto bg-emerald-600/5 group-hover:bg-emerald-600 dark:bg-emerald-600/10 dark:group-hover:bg-emerald-600 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-lg transition-all duration-500">
                    <i :class="item.icon" class="text-[30px] text-emerald-600 group-hover:text-white"></i>
                </div>

                <div class="mt-4">
                    <router-link to="#" class="text-lg font-semibold hover:text-emerald-600 transition-all duration-500">{{ item.name }}</router-link>
                    <p class="text-slate-400 mt-3 mb-2">{{ item.desc }}</p>
                    <router-link to="#" class="hover:text-emerald-600 font-medium transition-all duration-500">Read More <i class="uil uil-arrow-right"></i></router-link>
                </div>
            </div>

        </div>
    </div>
</template>

<script setup>

    import {defineProps} from 'vue'

    defineProps({
        jobstack:Boolean,
        features:Boolean
    })
    
    const datas = [
        {
            icon: 'uil uil-phone',
            name: '24/7 Support',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-atom',
            name: 'Tech & Startup Jobs',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-user-arrows',
            name: 'Quick & Easy',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-hourglass',
            name: 'Save Time',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-user-arrows',
            name: 'Apply with confidence',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-user-arrows',
            name: 'Reduce Hiring Bias',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-briefcase',
            name: 'Proactive Employers',
            desc: 'Many desktop publishing now use and a search for job.'
        },
        {
            icon: 'uil uil-user-arrows',
            name: 'No Missed Opportunities',
            desc: 'Many desktop publishing now use and a search for job.'
        },
    ]

</script>

<style lang="scss" scoped></style>