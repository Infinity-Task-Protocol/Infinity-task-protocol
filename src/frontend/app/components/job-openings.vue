<template>
    <div class="container md:my-24 my-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Job Openings</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="lg:flex justify-center mt-8">
            <div class="lg:w-3/4">
                <div v-for="item in datas" :key="item" class="group md:flex items-center justify-between p-6 rounded-lg shadow-sm hover:shadow-lg shadow-gray-200 dark:shadow-gray-700 transition-all duration-500 mt-6 first:mt-0">
                    <div>
                        <router-link to="/job-detail-one" class="text-lg font-semibold hover:text-emerald-600">{{item.job}}</router-link>
                        <p class="text-slate-400 mt-1">{{item.position}}</p>
                    </div>
                    <router-link to="/job-detail-one" class="py-1 px-5 inline-block font-semibold tracking-wide align-middle transition duration-500 ease-in-out text-base text-center rounded-full bg-transparent group-hover:bg-emerald-600 border border-slate-100 dark:border-slate-800 text-slate-400 group-hover:text-white md:mt-0 mt-4">Apply now</router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    const datas = [
        {
            job: 'Frontend Developer',
            position: 'Total Openings: 1'
        },
        {
            job: 'Business Development Manager',
            position: 'Total Openings: 2'
        },
        {
            job: 'Backend Developer',
            position: 'Total Openings: 4'
        },
    ]
 
</script>

<style lang="scss" scoped>

</style>