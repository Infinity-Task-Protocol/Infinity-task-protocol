<template>
    <div class="grid grid-cols-1 pb-8 text-center">
        <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Jobs</h3>
        <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
    </div>

    <div class="grid md:grid-cols-2 mt-8 gap-[30px]">
        <div v-for="item in datas" :key="item" class="group rounded-lg shadow-sm hover:shadow-lg shadow-gray-200 dark:shadow-gray-700 transition-all duration-500">
            <div class="flex items-center justify-between p-6">
                <div class="flex items-center">
                    <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                        <img :src="item.image" class="size-8"  alt="">
                    </div>

                    <div class="ms-3">
                        <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="block text-[16px] font-semibold hover:text-emerald-600 transition-all duration-500">{{item.name}}</router-link>
                        <span class="block text-sm text-slate-400">{{ item.day }}</span>
                    </div>
                </div>

                <router-link to="/job-apply" class="size-12 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out rounded-full bg-emerald-600/5 group-hover:bg-emerald-600 border border-slate-100 dark:border-slate-800 text-emerald-600 group-hover:text-white"><i class="uil uil-arrow-up-right"></i></router-link>
            </div>

            <div class="lg:flex items-center justify-between border-t border-gray-100 dark:border-gray-800 p-6">
                <div>
                    <router-link :to="{name: 'job-detail-one', params: {id: item.id}}" class="text-lg font-semibold hover:text-emerald-600">{{item.job}}</router-link>
                    <p class="text-slate-400 mt-1">Total Openings: 1</p>
                </div>

                <p class="text-slate-400 lg:mt-0 mt-4"><i class="uil uil-usd-circle text-[20px] text-emerald-600"></i> {{item.salary}}</p>
            </div>

            <div class="px-6 py-2 bg-slate-50 dark:bg-slate-800 flex justify-between items-center">
                <div>
                    <span class="inline-block font-semibold"><i class="mdi mdi-check-decagram mdi-18px text-blue-500 me-1"></i>Verified</span>
                    <ul class="list-none inline-block ms-1 text-yellow-400 space-x-0.5">
                        <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                        <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                        <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                        <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                        <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                        <li class="inline text-slate-400 font-semibold">4.8</li>
                    </ul>
                </div>
                <span class="inline-block me-1 text-slate-400"><i class="uil uil-map-marker text-[18px] text-slate-900 dark:text-white me-1"></i>{{item.location}}</span>
            </div>
        </div>
    </div>

    <div class="grid md:grid-cols-12 grid-cols-1 mt-8">
        <div class="md:col-span-12 text-center">
            <router-link to="/job-list-five" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Jobs <i class="uil uil-arrow-right align-middle"></i></router-link>
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
            image: logo1,
            name: 'Facebook',
            job: 'Web Designer / Developer',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'Australia'
        },
        {
            id: 2,
            image: logo2,
            name: 'Google',
            job: 'Marketing Director',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'USA'
        },
        {
            id: 3,
            image: logo3,
            name: 'Android',
            job: 'Application Developer',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'China'
        },
        {
            id: 4,
            image: logo4,
            name: 'Lenovo',
            job: 'Senior Product Designer',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'Dubai'
        },
        {
            id: 5,
            image: logo5,
            name: 'Spotify',
            job: 'C++ Developer',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'India'
        },
        {
            id: 6,
            image: logo6,
            name: 'Linkedin',
            job: 'Php Developer',
            day: '2 days ago',
            salary: '$950 - $1100/mo',
            location: 'Pakistan'
        },
    ]
</script>

<style lang="scss" scoped>

</style>