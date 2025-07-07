<template>
    <section class="relative md:py-24 py-16">
        <div class="container">
            <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-[30px]">
                <div v-for="item in datas" :key="item" class="group relative overflow-hidden bg-white dark:bg-slate-900 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700">
                    <div class="relative overflow-hidden">
                        <img :src="item.image" class="scale-110 group-hover:scale-100 transition-all duration-500" alt="">
                    </div>

                    <div class="relative p-6">
                        <div class="absolute start-6 -top-4">
                            <span class="bg-emerald-600 text-white text-[12px] px-2.5 py-1 font-semibold rounded-full h-5">{{item.name}}</span>
                        </div>

                        <div class="">
                            <div class="flex mb-4">
                                <span class="text-slate-400 text-sm"><i class="uil uil-calendar-alt text-slate-900 dark:text-white me-2"></i>{{ item.date }}</span>
                                <span class="text-slate-400 text-sm ms-3"><i class="uil uil-clock text-slate-900 dark:text-white me-2"></i>{{item.time}}</span>
                            </div>

                            <router-link :to="{name: 'blog-detail', params: {id: item.id}}" class="title text-lg font-semibold hover:text-emerald-600 duration-500 ease-in-out">{{ item.title }}</router-link>

                            <div class="flex justify-between items-center mt-3">
                                <router-link :to="{ name: 'blog-detail' , params: {id: item.id} }" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative p-0 border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">Read More <i class="uil uil-arrow-right"></i></router-link>
                                <span class="text-slate-400 text-sm">by <a href="" class="text-slate-900 dark:text-white hover:text-emerald-600 dark:hover:text-emerald-600 font-medium">{{item.company}}</a></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <pagination />
        </div>
    </section>
</template>

<script setup>
import Pagination from '~/components/Pagination.vue'
import blog1 from '@/assets/images/blog/01.jpg'
import blog2 from '@/assets/images/blog/02.jpg'
import blog3 from '@/assets/images/blog/03.jpg'
import blog4 from '@/assets/images/blog/04.jpg'
import blog5 from '@/assets/images/blog/05.jpg'
import blog6 from '@/assets/images/blog/06.jpg'
import blog7 from '@/assets/images/blog/07.jpg'
import blog8 from '@/assets/images/blog/08.jpg'
import blog9 from '@/assets/images/blog/09.jpg'

const datas = [
    {
        id: 1,
        image: blog1,
        name: 'Arts',
        date: '20th February, 2023',
        time: '5 min read',
        title: '11 Tips to Help You Get New Clients Through Cold Calling',
        company: 'Google'
    },
    {
        id: 2,
        image: blog2,
        name: 'Illustration',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'DigitalOcean launches first Canadian data centre in Toronto',
        company: 'Facebook'
    },
    {
        id: 3,
        image: blog3,
        name: 'Music',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'Using Banner Stands To Increase Trade Show Traffic',
        company: 'Linkedin'
    },
    {
        id: 4,
        image: blog4,
        name: 'Arts',
        date: '20th February, 2023',
        time: '5 min read',
        title: '11 Tips to Help You Get New Clients Through Cold Calling',
        company: 'Google'
    },
    {
        id: 5,
        image: blog5,
        name: 'Illustration',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'DigitalOcean launches first Canadian data centre in Toronto',
        company: 'Facebook'
    },
    {
        id: 6,
        image: blog6,
        name: 'Music',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'Using Banner Stands To Increase Trade Show Traffic',
        company: 'Linkedin'
    },
    {
        id: 7,
        image: blog7,
        name: 'Arts',
        date: '20th February, 2023',
        time: '5 min read',
        title: '11 Tips to Help You Get New Clients Through Cold Calling',
        company: 'Google'
    },
    {
        id: 8,
        image: blog8,
        name: 'Illustration',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'DigitalOcean launches first Canadian data centre in Toronto',
        company: 'Facebook'
    },
    {
        id: 9,
        image: blog9,
        name: 'Music',
        date: '20th February, 2023',
        time: '5 min read',
        title: 'Using Banner Stands To Increase Trade Show Traffic',
        company: 'Linkedin'
    },
]
</script>

<style lang="scss" scoped></style>