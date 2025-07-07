<template>
    <div class="container md:mt-24 mt-16">
        <div class="grid grid-cols-1 pb-8 text-center">
            <h3 class="mb-4 md:text-[26px] md:leading-normal text-2xl leading-normal font-semibold">Questions & Answers</h3>
            <p class="text-slate-400 max-w-xl mx-auto">Search all the open positions on the web. Get your own personalized salary estimate. Read reviews on over 30000+ companies worldwide.</p>
        </div>

        <div class="grid md:grid-cols-2 grid-cols-1 mt-8 gap-[30px]">

            <div v-for="item in datas" :key="item" class="flex">
                <i data-feather="help-circle" class="h-8 text-emerald-600 me-3"></i>
                <div class="flex-1">
                    <h5 class="mb-2 text-lg font-semibold">{{item.name}} <span class="text-emerald-600">{{item.name2}}</span> {{item.name3}}</h5>
                    <p class="text-slate-400">{{item.desc}}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    const datas = [
        {
            name: 'How our',
            name2: 'Jobstack',
            name3: 'work ?',
            desc: 'Due to its widespread use as filler text for layouts, non-readability is of great importance: human perception is tuned to recognize certain patterns and repetitions in texts.'
        },
        {
            name: ' What is the main process open account ?',
            desc: "If the distribution of letters and 'words' is random, the reader will not be distracted from making a neutral judgement on the visual impact."
        },
        {
            name: ' How to make unlimited data entry ?',
            desc: 'Furthermore, it is advantageous when the dummy text is relatively realistic so that the layout impression of the final publication is not compromised.'
        },
        {
            name: ' Is',
            name2: 'Jobstack',
            name3: 'safer to use with my account ?',
            desc: "The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century. Lorem Ipsum is composed in a pseudo-Latin language which more or less corresponds to 'proper' Latin."
        },
    ]
</script>

<style lang="scss" scoped>

</style>