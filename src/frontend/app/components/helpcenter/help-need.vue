<template>
    <div class="container">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-3xl text-2xl md:leading-snug leading-snug font-semibold">Find The Help You Need</h3>
            <p class="text-slate-400 max-w-xl mx-auto">We are a huge marketplace dedicated to connecting great artists of all Jobstack with their fans and unique token collectors!</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 md:grid-cols-2 mt-6 gap-[30px]">
            <div v-for="item in datas" :key="item" class="text-center px-6 mt-6">
                <div class="size-14 bg-emerald-600/5 text-emerald-600 rounded-xl text-2xl flex align-middle justify-center items-center mx-auto shadow-xs dark:shadow-gray-800">
                    <i :class="item.icon"></i>
                </div>

                <div class="content mt-7">
                    <router-link :to="item.link" class="title h5 text-lg font-semibold hover:text-emerald-600">{{ item.name }}</router-link>
                    <p class="text-slate-400 mt-3">{{ item.desc }}</p>

                    <div class="mt-5">
                        <router-link :to="item.link" class="inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-emerald-600 hover:text-emerald-600 after:bg-emerald-600">Read More <i class="uil uil-arrow-right"></i></router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
const datas = [
    {
        icon: 'uil uil-question-circle',
        name: 'FAQs',
        link: '/helpcenter-faqs',
        desc: 'The phrasal sequence of the is now so that many campaign and benefit'
    },
    {
        icon: 'uil uil-file-bookmark-alt',
        name: 'Guides / Support',
        link: '/helpcenter-guides',
        desc: 'The phrasal sequence of the is now so that many campaign and benefit'
    },
    {
        icon: 'uil uil-cog',
        name: 'Support Request',
        link: '/helpcenter-support',
        desc: 'The phrasal sequence of the is now so that many campaign and benefit'
    },
]
</script>

<style lang="scss" scoped></style>