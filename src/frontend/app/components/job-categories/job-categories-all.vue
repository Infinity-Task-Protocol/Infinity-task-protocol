<template>
        <div class="container">
            <div class="grid lg:grid-cols-5 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 gap-[30px]">
                <div v-for="item in datas" :key="item" class="group px-3 py-10 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 hover:shadow-emerald-600/10 dark:hover:shadow-emerald-600/10 text-center bg-white dark:bg-slate-900 hover:bg-emerald-600/5 dark:hover:bg-emerald-600/5 transition duration-500">
                    <div class="size-16 bg-emerald-600/5 group-hover:bg-emerald-600 text-emerald-600 group-hover:text-white rounded-md text-2xl flex align-middle justify-center items-center shadow-xs shadow-gray-200 dark:shadow-gray-700 transition duration-500 mx-auto">
                        <i :class="item.icon"></i>
                    </div>

                    <div class="content mt-6">
                        <a href="" class="title text-lg font-semibold hover:text-emerald-600">{{item.name}} <br>{{item.name2}}</a>
                        <p class="text-slate-400 mt-3">{{item.job}}</p>
                    </div>
                </div>
            </div>
        </div>
</template>

<script setup>
    const datas = [
        {
            icon: 'uil uil-gitlab',
            name: 'Business',
            name2: 'Development',
            job: '74 Jobs'
        },
        {
            icon: 'uil uil-book-open',
            name: 'Marketing &',
            name2: 'Communication',
            job: '20 Jobs'
        },
        {
            icon: 'uil uil-chart-pie-alt',
            name: 'Project',
            name2: 'Management',
            job: '35 Jobs'
        },
        {
            icon: 'uil uil-feedback',
            name: 'Customer',
            name2: 'Service',
            job: '46 Jobs'
        },
        {
            icon: 'uil uil-presentation-line',
            name: 'Software',
            name2: 'Engineering',
            job: '60 Jobs'
        },
        {
            icon: 'uil uil-gitlab',
            name: 'Human Resource',
            name2: 'HR',
            job: '74 Jobs'
        },
        {
            icon: 'uil uil-book-open',
            name: 'It &',
            name2: 'Networking',
            job: '20 Jobs'
        },
        {
            icon: 'uil uil-chart-pie-alt',
            name: 'Sales &',
            name2: 'Marketing',
            job: '35 Jobs'
        },
        {
            icon: 'uil uil-feedback',
            name: 'Project',
            name2: 'Manager',
            job: '46 Jobs'
        },
        {
            icon: 'uil uil-presentation-line',
            name: 'Data',
            name2: 'Science',
            job: '60 Jobs'
        },
    ]
</script>

<style lang="scss" scoped></style>