<template>
    <div class="md:flex justify-center">
        <div class="md:w-3/4">
            <div class="p-6 bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                <h5 class="text-xl font-medium mb-4">Overview :</h5>
                <p class="text-slate-400">It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text.</p>
                <p class="text-slate-400">In the 1960s, the text suddenly became known beyond the professional circle of typesetters and layout designers when it was used for Letraset sheets (adhesive letters on transparent film, popular until the 1980s) Versions of the text were subsequently included in DTP programmes such as PageMaker etc.</p>
                <p class="text-slate-400">There is now an abundance of readable dummy texts. These are usually used when a text is required purely to fill a space. These alternatives to the classic Lorem Ipsum texts are often amusing and tell short, funny or nonsensical stories.</p>
            
                <h5 class="text-xl font-medium mb-4 mt-8">We use your information to :</h5>
                <ul class="list-unstyled text-slate-400 mt-4">
                    <li v-for="item in datas" :key="item" class="flex mt-2"><i class="uil uil-arrow-right text-emerald-600 align-middle me-2"></i>{{item}}</li>
                </ul>

                <h5 class="text-xl font-medium mb-4 mt-8">Information Provided Voluntarily :</h5>
                <p class="text-slate-400">In the 1960s, the text suddenly became known beyond the professional circle of typesetters and layout designers when it was used for Letraset sheets (adhesive letters on transparent film, popular until the 1980s) Versions of the text were subsequently included in DTP programmes such as PageMaker etc.</p>

                <div class="mt-8">
                    <router-link to="#" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 text-white rounded-md">Print</router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    const datas = ['Digital Marketing Solutions for Tomorrow', 'Our Talented & Experienced Marketing Agency', 'Create your own skin to match your brand', 'Digital Marketing Solutions for Tomorrow', 'Our Talented & Experienced Marketing Agency', 'Create your own skin to match your brand']
</script>

<style lang="scss" scoped>

</style>