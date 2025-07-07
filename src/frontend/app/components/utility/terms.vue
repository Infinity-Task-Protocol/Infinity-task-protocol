<template>
    <div class="md:flex justify-center">
        <div class="md:w-3/4">
            <div class="p-6 bg-white dark:bg-slate-900 shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md">
                <h5 class="text-xl font-medium mb-4">Introduction :</h5>
                <p class="text-slate-400">It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text.</p>

                <h5 class="text-xl font-medium mb-4 mt-8">User Agreements :</h5>
                <p class="text-slate-400">The most well-known dummy text is the 'Lorem Ipsum', which is said to have <b class="text-danger-600">originated</b> in the 16th century. Lorem Ipsum is <b class="text-danger-600">composed</b> in a pseudo-Latin language which more or less <b class="text-danger-600">corresponds</b> to 'proper' Latin. It contains a series of real Latin words. This ancient dummy text is also <b class="text-danger-600">incomprehensible</b>, but it imitates the rhythm of most European languages in Latin script. The <b class="text-danger-600">advantage</b> of its Latin origin and the relative <b class="text-danger-600">meaninglessness</b> of Lorum Ipsum is that the text does not attract attention to itself or distract the viewer's <b class="text-danger-600">attention</b> from the layout.</p>
                <p class="text-slate-400 mt-3">There is now an <b class="text-danger-600">abundance</b> of readable dummy texts. These are usually used when a text is <b class="text-danger-600">required purely</b> to fill a space. These alternatives to the classic Lorem Ipsum texts are often amusing and tell short, funny or <b class="text-danger-600">nonsensical</b> stories.</p>
                <p class="text-slate-400 mt-3">It seems that only <b class="text-danger-600">fragments</b> of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text.</p>
                
                <h5 class="text-xl font-medium mb-4 mt-8">Restrictions :</h5>
                <p class="text-slate-400">You are specifically restricted from all of the following :</p>
                <ul class="list-none text-slate-400 mt-3">
                    <li v-for="item in datas" :key="item" class="flex mt-2"><i class="uil uil-arrow-right text-emerald-600 align-middle me-2"></i>{{item}}</li>
                </ul>

                <h5 class="text-xl font-medium mt-8">Users Question & Answer :</h5>

                <div id="accordion-collapse" data-accordion="collapse" class="mt-6">
                    <question />
                </div>

                <div class="mt-6">
                    <router-link to="#" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 text-white rounded-md">Accept</router-link>
                    <router-link to="#" class="py-1 px-5 inline-block font-semibold tracking-wide align-middle transition duration-500 ease-in-out text-base text-center bg-transparent hover:bg-emerald-600 border border-emerald-600 text-emerald-600 hover:text-white rounded-md ms-2">Decline</router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import question from '@/components/helpcenter/help-question.vue'
const datas = ['Digital Marketing Solutions for Tomorrow', 'Our Talented & Experienced Marketing Agency', 'Create your own skin to match your brand', 'Digital Marketing Solutions for Tomorrow', 'Our Talented & Experienced Marketing Agency', 'Create your own skin to match your brand']
    
</script>

<style lang="scss" scoped>

</style>