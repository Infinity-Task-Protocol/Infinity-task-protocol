<template>
    <div class="grid md:grid-cols-3 grid-cols-1 gap-[30px]">
        <div v-for="item in datas" :key="item" :class="item.class">
            <div class="p-6 py-8">
                <h6 class="text-lg font-bold uppercase mb-5 text-emerald-600">{{item.name}}</h6>

                <div class="flex mb-5">
                    <span class="text-xl font-semibold">{{ item.symbol }}</span>
                    <span class="price text-4xl font-semibold mb-0">{{ item.price }}</span>
                    <span class="text-xl font-semibold self-end mb-1">{{item.time}}</span>
                </div>

                <ul class="list-none text-slate-400 border-t border-gray-100 dark:border-gray-700 pt-5">
                    <li v-for="title in item.title" :key="title" class="my-2 flex"><i class="uil uil-check-circle text-emerald-600 text-xl me-2"></i> {{title}}</li>
                </ul>
                <router-link to="" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white rounded-md mt-5">Get Started</router-link>
            </div>
        </div>
    </div>
</template>

<script setup>
const datas = [
    {
        name: 'Free',
        symbol: '$',
        price: '0',
        time: '/mo',
        title:['Full Access', 'Source Files', 'Free Appointments', 'Enhanced Security'],
        class: 'group border border-transparent relative shadow-sm hover:shadow-md dark:shadow-gray-800 rounded-md bg-white dark:bg-slate-900 transition-all duration-500'
    },
    {
        name: 'Business',
        symbol: '$',
        price: '39',
        time: '/mo',
        title:['Full Access', 'Source Files', 'Free Appointments', 'Enhanced Security'],
        class: 'group border border-emerald-600 relative shadow-sm hover:shadow-md dark:shadow-gray-800 rounded-md z-2 bg-gray-50 dark:bg-slate-800 transition-all duration-500'
    },
    {
        name: 'Professional',
        symbol: '$',
        price: '59',
        time: '/mo',
        title:['Full Access', 'Source Files', 'Free Appointments', 'Enhanced Security'],
        class: 'group border border-transparent relative shadow-sm hover:shadow-md dark:shadow-gray-800 rounded-md bg-white dark:bg-slate-900 transition-all duration-500'
    },
]
</script>

<style lang="scss" scoped>

</style>