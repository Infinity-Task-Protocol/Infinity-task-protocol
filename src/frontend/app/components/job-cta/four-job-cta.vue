<template>
       <section class="py-24 w-full table relative bg-[url('../../assets/images/hero/bg3.jpg')] bg-center bg-no-repeat bg-cover jarallax">
            <div class="absolute inset-0 bg-slate-900/40"></div>
            <div class="container relative">
                <div class="grid md:grid-cols-2 grid-cols-1 gap-[30px]">
                    <div>
                        <h5 class="text-xl font-semibold text-white">Register for Candidate or User</h5>

                        <ul class="list-none text-white/50 mt-4">
                            <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> It has survived not only five centuries</li>
                            <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> There are many variations of passages</li>
                        </ul>

                        <div class="mt-4">
                            <router-link to="/candidate-profile" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 dark:border-emerald-600 text-white rounded-full">Apply Now</router-link>
                        </div>
                    </div>
                    
                    <div>
                        <h5 class="text-xl font-semibold text-white">Register for Companies</h5>

                        <ul class="list-none text-white/50 mt-4">
                            <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> Many desktop publishing packages</li>
                            <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> Contrary to popular belief</li>
                            <li class="mb-1 flex"><i class="uil uil-check-circle text-white text-xl me-2"></i> It is a long established fact that a reader</li>
                        </ul>

                        <div class="mt-4">
                            <router-link to="/job-post" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 dark:border-emerald-600 text-white rounded-full">Post Jobs</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </section>
</template>

<script setup>
import { onMounted } from 'vue'
import { jarallax } from 'jarallax'
import 'jarallax/dist/jarallax.min.css'

onMounted(() => {
  jarallax(document.querySelectorAll('.jarallax'), {
    speed: 0.5,
  })
})
</script>

<style lang="scss" scoped>

</style>