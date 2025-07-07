<template>
    <div class="container md:mt-24 mt-16">
        <div class="grid md:grid-cols-12 grid-cols-1 pb-8 items-end">
            <div class="lg:col-span-8 md:col-span-6 md:text-start text-center">
                <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Browse by Categories</h3>
                <p class="text-slate-400 max-w-xl">Search your career opportunity with our categories</p>
            </div>

            <div class="lg:col-span-4 md:col-span-6 md:text-end hidden md:block">
                <router-link to="#" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">All Categories <i class="uil uil-arrow-right align-middle"></i></router-link>
            </div>
        </div>

        <div class="grid xl:grid-cols-5 lg:grid-cols-4 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
            <div v-for="item in datas" :key="item" class="group p-4 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 bg-slate-50 dark:bg-slate-800 hover:bg-emerald-600 dark:hover:bg-emerald-600 transition-all duration-500">
                <h5 class="text-lg font-semibold group-hover:text-white">{{item.name}}</h5>
                <span class="block text-slate-400 group-hover:text-white/50 text-sm mt-1">{{item.jobs}}</span>

                <div class="mt-2">
                    <router-link to="/job-grid-one" class="text-emerald-600 dark:text-white/80 group-hover:text-white font-medium">Explore Jobs <i class="uil uil-arrow-right"></i></router-link>
                </div>
            </div>
            
        </div>

        <div class="grid md:grid-cols-12 grid-cols-1 md:hidden mt-8">
            <div class="md:col-span-12 text-center">
                <router-link to="#" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">All Categories <i class="uil uil-arrow-right align-middle"></i></router-link>
            </div>
        </div>
    </div>
</template>

<script setup>
const  datas = [
    {
        name: 'Human Resource',
        jobs: '90 Jobs Available'
    },
    {
        name: 'It & Networking',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Sales & Marketing',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Accounting',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Delivery Boy',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Data Science',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Project Manager',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Engineering',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Help Center',
        jobs: '90 Jobs Available'
    },
    {
        name: 'Full Stack Developer',
        jobs: '90 Jobs Available'
    },
]
</script>

<style lang="scss" scoped>

</style>