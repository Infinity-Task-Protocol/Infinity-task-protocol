<template>
    <div class="container">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Popular Jobs</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">
            <div v-for="item in datas" :key="item" class="group p-6 rounded-lg border border-emerald-600/20 dark:border-emerald-600/40 bg-white dark:bg-slate-900 hover:bg-emerald-600/[0.02] hover:dark:bg-emerald-600/5 hover:shadow-md hover:shadow-emerald-600/5 transition-all duration-500">
                <div class="flex justify-between items-start">
                    <div>
                        <div class="size-14 flex items-center justify-center bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-full mb-2">
                            <img :src="item.image" class="size-8"  alt="">
                        </div>
                        <router-link :to="{name: 'employer-detail', params: {id: item.id}}" class="text-lg hover:text-emerald-600 font-semibold transition-all duration-500">{{item.name}}</router-link>
                    </div>

                    <div class="flex items-center">
                        <router-link to="#" class="text-slate-100 dark:text-slate-700 focus:text-red-600 dark:focus:text-red-600 hover:text-red-600 dark:hover:text-red-600 text-2xl"><i class="mdi mdi-heart"></i></router-link>
                        <router-link to="#" class="size-9 font-semibold tracking-wide border align-middle transition duration-500 ease-in-out inline-flex items-center text-center justify-center text-base rounded-full bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white ms-1"><i data-feather="bookmark" class="size-4"></i></router-link>
                        <router-link to="/job-apply" class="size-9 font-semibold tracking-wide border align-middle transition duration-500 ease-in-out inline-flex items-center text-center justify-center text-base rounded-full bg-emerald-600/5 group-hover:bg-emerald-600 border-emerald-600/10 text-emerald-600 group-hover:text-white ms-1"><i class="uil uil-arrow-up-right"></i></router-link>
                    </div>
                </div>

                <div class="mt-3">
                    <router-link :to="{name: 'job-detail-one', params: {id: item.id}}" class="text-xl hover:text-emerald-600 font-semibold transition-all duration-500">{{item.job}}</router-link>
                    <p class="text-slate-400 mt-2">{{item.title}}</p>

                    <div class="mt-3">
                        <router-link to="#">
                            <span class="bg-orange-500/5 hover:bg-orange-500/20 dark:bg-orange-500/10 hover:dark:bg-orange-500/30 inline-block text-orange-500 px-4 text-[14px] font-medium rounded-full mt-2 me-1 transition-all duration-500">{{item.type}}</span>
                        </router-link>
                        <router-link to="#">
                            <span class="bg-purple-600/5 hover:bg-purple-600/20 dark:bg-purple-600/10 hover:dark:bg-purple-600/30 inline-block text-purple-600 px-4 text-[14px] font-medium rounded-full mt-2 me-1 transition-all duration-500">{{item.salary}}</span>
                        </router-link>
                        <router-link to="#">
                            <span class="bg-emerald-600/5 hover:bg-emerald-600/20 dark:bg-emerald-600/10 hover:dark:bg-emerald-600/30 inline-block text-emerald-600 px-4 text-[14px] font-medium rounded-full mt-2 transition-all duration-500"><i class="uil uil-map-marker"></i> {{item.location}}</span>
                        </router-link>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid md:grid-cols-12 grid-cols-1 mt-8">
            <div class="md:col-span-12 text-center">
                <router-link to="/job-grid-four" class="inline-block font-semibold tracking-wide border align-middle transition text-base text-center relative border-none after:content-[''] after:absolute after:h-px after:w-0 after:end-0 after:bottom-0 after:start-0 after:transition-all after:duration-500 hover:after:w-full hover:after:end-auto text-slate-400 hover:text-emerald-600 after:bg-emerald-600 duration-500 ease-in-out">See More Jobs <i class="uil uil-arrow-right align-middle"></i></router-link>
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
            image: logo1,
            name: 'Facebook',
            job: 'Web Designer / Developer',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
        {
            id: 2,
            image: logo2,
            name: 'Google',
            job: 'Marketing Director',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
        {
            id: 3,
            image: logo3,
            name: 'Android',
            job: 'Application Developer',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
        {
            id: 4,
            image: logo4,
            name: 'Lenovo',
            job: 'Senior Product Designer',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
        {
            id: 5,
            image: logo5,
            name: 'Spotify',
            job: 'C++ Developer',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
        {
            id: 6,
            image: logo6,
            name: 'Linkedin',
            job: 'Php Developer',
            title: 'Looking for an experienced Web Designer for an our company.',
            type: 'Full Time',
            salary: '$4,000 - $4,500',
            location: 'Australia'
        },
    ]
</script>

<style lang="scss" scoped>

</style>