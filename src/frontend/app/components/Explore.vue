<template>
    <div class="container-fluid md:mt-24 mt-16">
        <div class="container">
            <div class="grid grid-cols-1">
                <div class="relative overflow-hidden lg:px-8 px-6 py-10 rounded-xl shadow-lg shadow-gray-200 dark:shadow-gray-700">
                    <div class="grid md:grid-cols-12 grid-cols-1 items-center gap-[30px]">
                        <div class="lg:col-span-8 md:col-span-7">
                            <div class="md:text-start text-center relative z-1">
                                <h3 class="text-2xl font-semibold text-black dark:text-white mb-4">Explore a job now!</h3>
                                <p class="text-slate-400 max-w-xl">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
                            </div>
                        </div>
    
                        <div class="lg:col-span-4 md:col-span-5">
                            <div class="text-end relative z-1">
                                <router-link to="/employer-detail" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 dark:border-emerald-600 text-white rounded-md">Apply Now</router-link>
                                <router-link to="/aboutus" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white rounded-md ms-2">Learn More</router-link>
                            </div>
                        </div>
                    </div>
    
                    <div class="absolute -top-5 -start-5">
                        <div class="uil uil-envelope lg:text-[150px] text-7xl text-black/5 dark:text-white/5 ltr:-rotate-45 rtl:rotate-45"></div>
                    </div>
    
                    <div class="absolute -bottom-5 -end-5">
                        <div class="uil uil-pen lg:text-[150px] text-7xl text-black/5 dark:text-white/5 rtl:-rotate-90"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
  
</script>

<style lang="scss" scoped>

</style>