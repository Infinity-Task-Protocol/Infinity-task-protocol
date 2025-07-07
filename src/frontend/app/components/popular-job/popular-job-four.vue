<template>
        <section class="relative bg-slate-50 dark:bg-slate-800 md:py-24 py-16">
            <div class="container">
                <div class="grid grid-cols-1 pb-8 text-center">
                    <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Jobs</h3>
                    <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
                </div>

                <div class="grid lg:grid-cols-2 md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
                    <div v-for="item in datas" :key="item" class="group relative overflow-hidden bg-white dark:bg-slate-900 shadow-sm hover:shadow-md shadow-gray-200 dark:shadow-gray-700 dark:hover:shadow-gray-700 hover:-mt-2 rounded-md transition-all duration-500 h-fit">
                        <div class="p-6">
                            <div class="flex items-center">
                                <div class="size-14 min-w-[56px] flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                                    <img :src="item.image" class="size-8"  alt="">
                                </div>
    
                                <div class="ms-3">
                                    <router-link :to="{name: 'job-detail-three', params:{id: item.id}}" class="inline-block text-[16px] font-semibold hover:text-emerald-600 transition-all duration-500 me-1">{{item.name}}</router-link>
                                    <span class="inline-block text-sm text-slate-400">{{item.day}}</span>
                                    <div>
                                        <span class="bg-emerald-600/10 inline-block text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full me-1">{{item.type}}</span>
                                        <span class="text-sm font-medium inline-block me-1">Est. time: <span class="text-slate-400">{{item.time}}</span></span>
                                        <span class="text-sm font-medium inline-block me-1">Hourly: <span class="text-slate-400">$16 - $20</span></span>
                                    </div>
                                </div>
                            </div>
    
                            <p class="text-slate-400 py-3">{{item.title}}</p>
    
                            <div>
                                <span v-for="language in item.language" :key="language" class="bg-slate-100 dark:bg-slate-800 inline-block text-slate-900 dark:text-slate-300 text-xs px-2.5 py-0.5 font-semibold rounded-full me-1">{{language}}</span>
                            </div>
                        </div>

                        <div class="px-6 py-2 bg-slate-50 dark:bg-slate-800 lg:flex justify-between items-center">
                            <div class="lg:inline-block flex justify-between">
                                <span class="inline-block me-1 font-semibold"><i class="mdi mdi-check-decagram mdi-18px text-blue-500 me-1"></i>Verified</span>
                                <ul class="list-none inline-block me-1 text-yellow-400 space-x-0.5">
                                    <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                                    <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                                    <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                                    <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                                    <li class="inline"><i class="mdi mdi-star text-lg"></i></li>
                                    <li class="inline text-slate-400 font-semibold">4.8</li>
                                </ul>
                                <span class="inline-block me-1 text-slate-400"><i class="uil uil-map-marker text-[18px] text-slate-900 dark:text-white me-1"></i>{{item.location}}</span>
                            </div>

                            <router-link to="/job-apply" class="py-[5px] px-4 text-sm inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-center rounded-md bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white md:ms-2 w-full lg:w-auto lg:mt-0 mt-4">Apply Now</router-link>
                        </div>
                        <router-link to="#" class="size-9 font-semibold tracking-wide border align-middle transition duration-500 ease-in-out inline-flex items-center text-center justify-center text-base rounded-full bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white absolute top-0 end-0 m-3"><i data-feather="bookmark" class="size-4"></i></router-link>
                    </div>

                </div>

                <div class="grid md:grid-cols-12 grid-cols-1 mt-8">
                    <div class="md:col-span-12 text-center">
                        <router-link to="/job-grid-two" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Jobs <i class="uil uil-arrow-right align-middle"></i></router-link>
                    </div>
                </div>
            </div>
        </section>
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
            name: 'Web Designer',
            day: '2 days ago',
            type: 'Full Time',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'Australia'
        },
        {
            id: 2,
            image: logo2,
            name: 'Marketing Director',
            day: '2 days ago',
            type: 'Part Time',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'USA'
        },
        {
            id: 3,
            image: logo3,
            name: 'App Developer',
            day: '2 days ago',
            type: 'Remote',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'China'
        },
        {
            id: 4,
            image: logo4,
            name: 'Product Designer',
            day: '2 days ago',
            type: 'WFH',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'Dubai'
        },
        {
            id: 5,
            image: logo5,
            name: 'C++ Developer',
            day: '2 days ago',
            type: 'Full Time',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'India'
        },
        {
            id: 6,
            image: logo6,
            name: 'Php Developer',
            day: '2 days ago',
            type: 'Remote',
            time: '1 to 3 months',
            salary: '$16 - $20',
            title: 'Looking for an experienced Web Designer for an our company.',
            language: ['HTML', 'CSS', 'SASS', 'SCSS', 'Photoshop', 'Graphics', 'Bootstrap'],
            location: 'Pakistan'
        },
    ]
</script>

<style lang="scss" scoped>

</style>