<template>
    <div v-for="item in datas" :key="item" class="group relative overflow-hidden md:flex justify-between items-center rounded shadow-sm hover:shadow-md shadow-gray-200 dark:shadow-gray-700 transition-all duration-500 p-5">
        <div class="flex items-center">
            <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                <img :src="item.image" class="size-8"  alt="">
            </div>
            <router-link :to="{name: 'job-detail-two', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold transition-all duration-500 ms-3 min-w-[180px]">{{item.job}}</router-link>
        </div>

        <div class="md:block flex justify-between md:mt-0 mt-4">
            <span class="block"><span class="bg-emerald-600/10 inline-block text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full">{{item.type}}</span></span>
            <span class="block text-slate-400 text-sm md:mt-1 mt-0"><i class="uil uil-clock"></i> {{item.day}}</span>
        </div>

        <div class="md:block flex justify-between md:mt-0 mt-2">
            <span class="text-slate-400"><i class="uil uil-map-marker"></i> {{item.country}}</span>
            <span class="block font-semibold md:mt-1 mt-0">{{item.salary}}</span>
        </div>

        <div class="md:mt-0 mt-4">
            <a href="" class="size-9 font-semibold tracking-wide border align-middle transition duration-500 ease-in-out inline-flex items-center text-center justify-center text-base rounded-full bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white md:relative absolute top-0 end-0 md:m-0 m-3"><i data-feather="bookmark" class="size-4"></i></a>
            <router-link :to="{name: 'job-apply', params: {id: item.id}}" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center rounded-md bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white md:ms-2 w-full md:w-auto">Apply Now</router-link>
        </div>

        <span :class="item.class"><i :class="item.icon"></i></span>
    </div>
             
</template>

<script setup>
    import logo1 from '@/assets/images/company/facebook-logo.png'
    import logo2 from '@/assets/images/company/google-logo.png'
    import logo3 from '@/assets/images/company/android.png'
    import logo4 from '@/assets/images/company/lenovo-logo.png'
    import logo5 from '@/assets/images/company/spotify.png'
    import logo6 from '@/assets/images/company/linkedin.png'
    import logo7 from '@/assets/images/company/circle-logo.png'
    import logo8 from '@/assets/images/company/skype.png'
    import logo9 from '@/assets/images/company/snapchat.png'
    import logo10 from '@/assets/images/company/shree-logo.png'
    import logo11 from '@/assets/images/company/telegram.png'
    import logo12 from '@/assets/images/company/whatsapp.png'

    const datas = [
        {
            id: 1,
            image: logo1,
            day: '20th Feb 2023',
            type: 'Full Time',
            job: 'Web Designer',
            country: 'Australia',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
        {
            id: 2,
            image: logo2,
            day: '20th Feb 2023',
            type: 'Part Time',
            job: 'Marketing Director',
            country: 'USA',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 3,
            image: logo3,
            day: '20th Feb 2023',
            type: 'Remote',
            job: 'Application Developer',
            country: 'China',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 4,
            image: logo4,
            day: '20th Feb 2023',
            type: 'WFH',
            job: 'Product Designer',
            country: 'Dubai',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 5,
            image: logo5,
            day: '20th Feb 2023',
            type: 'Full Time',
            job: 'C++ Developer',
            country: 'India',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
        {
            id: 6,
            image: logo6,
            day: '20th Feb 2023',
            type: 'Remote',
            job: 'Php Developer',
            country: 'Pakistan',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
        {
            id: 7,
            image: logo7,
            day: '20th Feb 2023',
            type: 'Full Time',
            job: 'Web Designer',
            country: 'Australia',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
        {
            id: 8,
            image: logo8,
            day: '20th Feb 2023',
            type: 'Part Time',
            job: 'Marketing Director',
            country: 'USA',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 9,
            image: logo9,
            day: '20th Feb 2023',
            type: 'Remote',
            job: 'App Developer',
            country: 'China',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 10,
            image: logo10,
            day: '20th Feb 2023',
            type: 'WFH',
            job: 'Product Designer',
            country: 'Dubai',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
        },
        {
            id: 11,
            image: logo11,
            day: '20th Feb 2023',
            type: 'Full Time',
            job: 'C++ Developer',
            country: 'India',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
        {
            id: 12,
            image: logo12,
            day: '20th Feb 2023',
            type: 'Remote',
            job: 'Php Developer',
            country: 'Pakistan',
            salary: '$4,000 - $4,500',
            class: 'w-24 bg-yellow-400 text-white text-center absolute ltr:-rotate-45 rtl:rotate-45 -start-[30px] top-1',
            icon: 'uil uil-star'
        },
    ]

</script>

<style lang="scss" scoped>

</style>