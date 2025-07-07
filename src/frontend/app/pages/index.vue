<template>
  <section class="relative table w-full py-36 bg-[url('../../assets/images/hero/bg.jpg')] bg-top bg-no-repeat bg-cover">
      <div class="absolute inset-0 bg-emerald-900/90"></div>
      <div class="container">
          <div class="grid grid-cols-1 text-center mt-10">
              <h3 class="md:text-3xl text-2xl md:leading-snug tracking-wide leading-snug font-medium text-white"> Guides & Support</h3>
          </div>
      </div>

      <div class="absolute text-center z-10 bottom-5 start-0 end-0 mx-3">
          <ul class="breadcrumb tracking-[0.5px] breadcrumb-light mb-0 inline-block">
              <li class="inline breadcrumb-item text-[15px] font-semibold duration-500 ease-in-out text-white/50 hover:text-white">
                  <NuxtLink to="/">Jobstack</NuxtLink></li>
          </ul>
      </div>
  </section>
  <div class="relative">
      <div class="shape absolute start-0 end-0 sm:-bottom-px -bottom-[2px] overflow-hidden z-1 text-white dark:text-slate-900">
          <svg class="w-full h-auto" viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
          </svg>
      </div>
  </div>

  <section class="relative md:py-24 py-16">
      <div class="container">
          <HelpcenterGuides />
      </div>

  </section>

</template>

<script setup>


</script>

<style lang="scss" scoped></style>