<template>
    <div class="container">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">How it's Work?</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 md:grid-cols-2 mt-6 gap-[30px]">
            <div v-for="item in datas" :key="item" :class="item.class">
                <div class="size-14 bg-emerald-600/5 text-emerald-600 rounded-xl text-2xl flex align-middle justify-center items-center mx-auto shadow-xs dark:shadow-gray-800">
                    <i :class="item.icon"></i>
                </div>

                <div class="content mt-7">
                    <router-link to="#" class="title h5 text-lg font-semibold hover:text-emerald-600">{{item.name}}</router-link>
                    <p class="text-slate-400 mt-3">{{item.desc}}</p>
                    
                    <div class="mt-5">
                        <router-link to="#" class="inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-emerald-600 hover:text-emerald-600 after:bg-emerald-600">Read More <i class="uil uil-arrow-right"></i></router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    const datas = [
        {
            icon: 'uil uil-airplay',
            name: 'Create Account',
            desc: 'The phrasal sequence of the is now so that many campaign and benefit',
            class: 'p-6 hover:shadow-xl hover:shadow-gray-100 dark:hover:shadow-gray-800 transition duration-500 rounded-2xl mt-6 text-center'
        },
        {
            icon: 'uil uil-shutter',
            name: 'Complete Your Profile',
            desc: 'The phrasal sequence of the is now so that many campaign and benefit',
            class: 'p-6 shadow-xl shadow-gray-100 dark:shadow-gray-800 transition duration-500 rounded-2xl mt-6 text-center'
        },
        {
            icon: 'uil uil-camera-plus',
            name: 'Apply Job or Hire',
            desc: 'The phrasal sequence of the is now so that many campaign and benefit',
            class: 'p-6 hover:shadow-xl hover:shadow-gray-100 dark:hover:shadow-gray-800 transition duration-500 rounded-2xl mt-6 text-center'
        },
    ]
</script>

<style lang="scss" scoped>

</style>