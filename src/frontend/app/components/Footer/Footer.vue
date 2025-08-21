<template>
        <footer class="relative bg-slate-900 dark:bg-slate-800">
            <div class="container">
                <div class="grid grid-cols-1">
                    <div class="relative py-12">
                        <div class="relative w-full">
                            <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px]">
                                <div class="md:col-span-3">
                                    <NuxtLink to="/" class="flex justify-center md:justify-start focus:outline-none">
                                        Infinity Task
                                    </NuxtLink>
                                </div>
                        
                                <div class="md:col-span-9">
                                    <ul class="list-disc footer-list md:text-end text-center">
                                        <li v-for="item in datas" :key="item" class="inline-block me-3"><router-link :to="item.link" class="text-gray-300 hover:text-gray-400 duration-500 ease-in-out font-medium">{{item.name}}</router-link></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
</template>

<script setup>
import {ref} from 'vue'
import logo from '@/assets/images/logo-light.png'

const icons = [
    {
        icon: 'uil uil-shopping-cart align-middle',
        link: 'https://1.envato.market/jobstack-vue'
    },
    {
        icon: 'uil uil-dribbble align-middle',
        link: 'https://dribbble.com/shreethemes'
    },
    {
        icon: 'uil uil-behance',
        link: 'https://www.behance.net/shreethemes'
    },
    {
        icon: 'uil uil-linkedin',
        link: 'http://linkedin.com/company/shreethemes'
    },
    {
        icon: 'uil uil-facebook-f align-middle',
        link: 'https://www.facebook.com/shreethemes'
    },
    {
        icon: 'uil uil-instagram align-middle',
        link: 'https://www.instagram.com/shreethemes/'
    },
    {
        icon: 'uil uil-twitter align-middle',
        link: 'https://twitter.com/shreethemes'
    },
    {
        icon: 'uil uil-envelope align-middle',
        link: 'mailto:support@shreethemes.in'
    },
]

const  datas = [
    {
        name: 'Home',
        link: '/'
    },
    {
        name: 'How it works',
        link: '/'
    },
    {
        name: 'Create a job',
        link: '/'
    },
    {
        name: 'About us',
        link: '/'
    },
    {
        name: 'Contact us',
        link: '/'
    },
]

const date = ref(new Date().getFullYear())
</script>

<style lang="scss" scoped>

</style>