
<script setup lang="ts">

import image from '@/assets/images/team/01.jpg'
// import bg from '@/assets/images/hero/bg5.jpg'
import logo1 from '@/assets/images/company/shree-logo.png'
import bgImage from '@/assets/images/hero/curve-shape-dark.png'
import CandidateProfile from "~/components/candidates/candidate-profile.vue";

definePageMeta({
  middleware: [
    'auth',
  ],
});

const session = useSessionStore()
const user = session.user

console.log(user.name)

 const blobToImage = (uint8: number[], mimeType = 'image/png') => {
  const binary = String.fromCharCode(...uint8)
  const base64 = btoa(binary)
  return `data:${mimeType};base64,${base64}`
}
</script>

<template>
  <section class="relative lg:mt-24 mt-[74px]">
    <div class="container">
      <div class="relative shrink-0">
        <img :src="user?.coverPhoto ? blobToImage(user?.coverPhoto) : bgImage " class="h-64 w-full object-cover lg:rounded-xl shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
      </div>

      <div class="md:flex mx-4 -mt-12">
        <div class="md:w-full">
          <div class="relative flex items-end justify-between">
            <div class="relative flex items-end">
              <img :src=" `https://avatar.iran.liara.run/username?username=[${user.name}]`" class="size-28 rounded-full shadow-sm dark:shadow-gray-800 ring-4 ring-slate-50 dark:ring-slate-800" alt="">
              <div class="ms-4">
                <h5 class="text-lg font-semibold">{{user?.name ? user.name : ""}}</h5>
                <p class="text-slate-400">{{user?.position ? user.position : ""}}</p>
              </div>
            </div>

            <div class="">
              <nuxt-link to="account/edit" class="size-9 font-semibold tracking-wide border align-middle transition duration-500 ease-in-out inline-flex items-center text-center justify-center text-base rounded-full bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white"><i data-feather="settings" class="size-4"></i></nuxt-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="relative mt-12 md:pb-24 pb-16">
    <div class="container">
      <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px]">
        <div class="lg:col-span-8 md:col-span-7">
          <h5 class="text-xl font-semibold">{{ user?.name ? user?.name : 'Mr. Calvin carlo' }}</h5>


          <div class="text-slate-400 mt-4">
            <p class="mb-2">
              {{ user?.bio }}
            </p>
          </div>

          <h4 class="mt-6 text-xl font-semibold">Skills :</h4>
          <div class="grid lg:grid-cols-2 grid-cols-1 mt-6 gap-6">
            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">WordPress</span>
                <span class="text-slate-400">84%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 84%"></div>
              </div>
            </div>

            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">JavaScript</span>
                <span class="text-slate-400">79%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 79%"></div>
              </div>
            </div>

            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">HTML</span>
                <span class="text-slate-400">95%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 95%"></div>
              </div>
            </div>

            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">Figma</span>
                <span class="text-slate-400">85%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 85%"></div>
              </div>
            </div>

            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">Photoshop</span>
                <span class="text-slate-400">70%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 70%"></div>
              </div>
            </div>

            <div>
              <div class="flex justify-between mb-2">
                <span class="text-slate-400">Illustration</span>
                <span class="text-slate-400">65%</span>
              </div>
              <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-[6px]">
                <div class="bg-emerald-600 h-[6px] rounded-full" style="width: 65%"></div>
              </div>
            </div>
          </div>

          <!-- <h4 class="mt-6 text-xl font-semibold">Experience :</h4>

          <div class="flex mt-6">
            <div class="text-slate-400 font-semibold min-w-[80px] text-center">
              <img :src="logo1" class="size-16 mx-auto mb-2 block" alt=""> 2019-22
            </div>

            <div class="ms-4">
              <h5 class="text-lg font-medium mb-0">Full Stack Developer</h5>
              <span class="text-slate-400 company-university">Shreethemes - India</span>
              <p class="text-slate-400 mt-2 mb-0">It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text. </p>
            </div>
          </div>

          <div class="flex mt-6">
            <div class="text-slate-400 font-semibold min-w-[80px] text-center">
              <img :src="logo2" class="size-16 mx-auto mb-2 block" alt=""> 2017-19
            </div>

            <div class="ms-4">
              <h5 class="text-lg font-medium mb-0">Back-end Developer</h5>
              <span class="text-slate-400 company-university">CircleCI - U.S.A.</span>
              <p class="text-slate-400 mt-2 mb-0">It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text. </p>
            </div>
          </div> -->

          <!-- <div class="rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 mt-6">
            <h5 class="text-xl font-semibold">Contact Me:</h5>

            <form>
              <div class="grid grid-cols-12 gap-2">
                <div class="md:col-span-6 col-span-12">
                  <label for="name" class="font-semibold">Your Name:</label>
                  <input name="name" id="name" type="text" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Name :">
                </div>

                <div class="md:col-span-6 col-span-12">
                  <label for="email" class="font-semibold">Your Email:</label>
                  <input name="email" id="email" type="email" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Email :">
                </div>

                <div class="col-span-12">
                  <label for="subject" class="font-semibold">Your Question:</label>
                  <input name="subject" id="subject" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Subject :">
                </div>

                <div class="col-span-12">
                  <label for="comments" class="font-semibold">Your Comment:</label>
                  <textarea name="comments" id="comments" class="form-input border border-slate-100 dark:border-slate-800 mt-2 textarea" placeholder="Message :"></textarea>
                </div>
              </div>
              <button type="submit" id="submit" name="send" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 text-white rounded-md">Send Message</button>
            </form>
          </div> -->
        </div>
        <!-- <CandidateProfile /> -->
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped></style>