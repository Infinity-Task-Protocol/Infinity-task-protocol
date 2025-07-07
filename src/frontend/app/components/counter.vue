<template>
    <div class="container">
        <div class="relative grid md:grid-cols-3 grid-cols-1 items-center gap-[30px] z-1">
            <div class="counter-box text-center">
                <h1 class="lg:text-5xl text-4xl font-semibold mb-2 dark:text-white flex justify-center"><count-up class="counter-value" :start-val="1010" :end-val="1548">1010</count-up>K+</h1>
                <h5 class="counter-head text-sm font-semibold text-slate-400 uppercase">Job Fulfillment</h5>
            </div>
            
            <div class="counter-box text-center">
                <h1 class="lg:text-5xl text-4xl font-semibold mb-2 dark:text-white flex justify-center"><count-up class="counter-value" :start-val="2" :end-val="25">2</count-up>+</h1>
                <h5 class="counter-head text-sm font-semibold text-slate-400 uppercase">Branches</h5>
            </div>
            
            <div class="counter-box text-center">
                <h1 class="lg:text-5xl text-4xl font-semibold mb-2 dark:text-white flex justify-center"><count-up class="counter-value" :start-val="0" :end-val="9">0</count-up>+</h1>
                <h5 class="counter-head text-sm font-semibold text-slate-400 uppercase">Years Experience</h5>
            </div>
        </div>
    </div>
</template>

<script setup>
    import CountUp from 'vue-countup-v3'
</script>

<style lang="scss" scoped>

</style>