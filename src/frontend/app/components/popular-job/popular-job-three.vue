<template>

    <div class="container md:mt-24 mt-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Jobs</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
            <div v-for="item in datas" :key="item"
                class="group relative overflow-hidden rounded-md shadow-sm dark:shadow-gray-800">
                <div class="p-6">
                    <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="title h5 text-lg font-semibold hover:text-emerald-600">{{ item.name }}</router-link>
                    <p class="text-slate-400 mt-2"><i class="uil uil-clock text-emerald-600"></i> {{ item.day }}</p>

                    <div class="flex justify-between items-center mt-4">
                        <span class="bg-emerald-600/5 text-emerald-600 text-xs font-bold px-2.5 py-0.5 rounded h-5">{{ item.type }}</span>
                        <p class="text-slate-400"><i class="uil uil-usd-circle text-emerald-600"></i> {{ item.salary }}</p>
                    </div>
                </div>

                <div class="flex items-center p-6 border-t border-gray-100 dark:border-gray-800">
                    <img :src="item.image" class="size-12 shadow-md dark:shadow-gray-800 rounded-md p-2 bg-white dark:bg-slate-900" alt="">

                    <div class="ms-3">
                        <router-link :to="{name: 'job-detail-one', params: {id: item.id}}"> <h6 class="mb-0 font-semibold text-base">{{ item.company }}</h6></router-link>                       
                        <span class="text-slate-400 text-sm">{{ item.location }}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid md:grid-cols-12 grid-cols-1 mt-8">
            <div class="md:col-span-12 text-center">
                <router-link to="/job-grid-two" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Jobs <i class="uil uil-arrow-right align-middle"></i></router-link>
            </div>
        </div>
    </div>
</template>

<script setup>
    import logo1 from '@/assets/images/company/facebook-logo.png'
    import logo2 from '@/assets/images/company/google-logo.png'
    import logo3 from '@/assets/images/company/android.png'
    import logo4 from '@/assets/images/company/lenovo-logo.png'
    import logo5 from '@/assets/images/company/spotify.png'
    import logo6 from '@/assets/images/company/linkedin.png'

const datas = [
    {
        id: 1,
        name: 'Web Designer / Developer',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$950 - $1100/mo',
        image: logo1,
        company: 'Facebook Ltd.',
        location: 'Australia',
    },
    {
        id: 2,
        name: 'Marketing Director',
        day: 'Posted 3 Days ago',
        type: 'Remote',
        salary: '$2500 - $2600/mo',
        image: logo2,
        company: 'Google Ltd.',
        location: 'America',
    },
    {
        id: 3,
        name: 'Application Developer',
        day: 'Posted 3 Days ago<',
        type: 'Freelance',
        salary: '$3500 - $3600/mo',
        image: logo3,
        company: 'Android Ltd.',
        location: 'Canada',
    },
    {
        id: 4,
        name: 'Senior Product Designer',
        day: 'Posted 3 Days ago',
        type: 'Part Time',
        salary: '$2000 - $2500/mo',
        image: logo4,
        company: 'Lenovo Ltd.',
        location: 'UK',
    },
    {
        id: 5,
        name: 'Web Designer / Developer',
        day: 'Posted 3 Days ago',
        type: 'Full Time',
        salary: '$1500 - $1600/mo',
        image: logo5,
        company: 'Spotify Ltd.',
        location: 'China',
    },
    {
        id: 6,
        name: 'Php Developer',
        day: 'Posted 3 Days ago',
        type: 'Part time',
        salary: '$500 - $600/mo',
        image: logo6,
        company: 'Linkedin Ltd.',
        location: 'India',
    },
]
</script>

<style lang="scss" scoped></style>