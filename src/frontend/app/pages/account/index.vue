
<script setup lang="ts">

import image from '@/assets/images/team/01.jpg'
// import bg from '@/assets/images/hero/bg5.jpg'
import logo1 from '@/assets/images/company/shree-logo.png'
import bgImage from '@/assets/images/hero/curve-shape-dark.png'
import CandidateProfile from "~/components/candidates/candidate-profile.vue";
import { blobToImageUrl } from "../../utils/imageManager"

definePageMeta({
  middleware: [
    'auth',
  ],
});

const session = useSessionStore()
const user = session.user

console.log(user?.name)

const blobToImage = (image: number[], defualt: string)  => {
  return image ? blobToImageUrl(image) : defualt;
}

</script>

<template>
  <section class="relative lg:mt-24 mt-[74px]">
    <div class="container">
      <div class="relative shrink-0 group">
        <img
          :src="user?.coverImage[0]? blobToImageUrl(user.coverImage[0]) as string : bgImage"
          class="h-64 w-full object-cover lg:rounded-xl shadow-sm shadow-gray-200 dark:shadow-gray-700"
          alt=""
        >
        <svg
          width="24"
          height="24"
          viewBox="0 0 24 24"
          focusable="false"
          class="absolute bottom-10 right-10 text-white fill-white bg-gray-700 rounded-full p-1 size-8 opacity-0 transition-opacity duration-100 group-hover:opacity-100"
        >
          <path d="M20 5h-3.17L15 3H9L7.17 5H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0
                14H4V7h16v12zM12 9c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z">
          </path>
        </svg>
      </div>

      <div class="md:flex mx-4 -mt-12">
        <div class="md:w-full">
          <div class="relative flex items-end justify-between">
            <div class="relative flex items-end">
              <div class="relative shrink-0 group">
                <img 
                :src="user?.avatar[0]? blobToImageUrl(user.avatar[0]) as string : `https://avatar.iran.liara.run/username?username=${user?.name}`" 
                class="size-28 rounded-full shadow-sm dark:shadow-gray-800 ring-4 ring-slate-50 dark:ring-slate-800" 
                alt=""
                >
                
                  <svg
                    width="24"
                    height="24"
                    
                    viewBox="0 0 24 24"
                    focusable="false"
                    class="absolute bottom-3 right-3 text-white fill-white bg-gray-600 rounded-full size-6 p-[2px] opacity-0 transition-opacity duration-100 group-hover:opacity-100"
                  >
                    <path d="M20 5h-3.17L15 3H9L7.17 5H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0
                          14H4V7h16v12zM12 9c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z">
                    </path>
                  </svg>
              </div>
              <div class="ms-4">
                <h5 class="text-lg font-semibold">{{user? user.name : ""}}</h5>
                <p class="text-slate-400">{{user?.position[0] ? user.position : ""}}</p>
              </div>
            </div>

            <div class="">
              <nuxt-link 
                to="account/edit" 
                class="p-1 tracking-wide border transition duration-500 ease-in-out inline-flex rounded-full bg-emerald-600/5 hover:bg-emerald-600 border-emerald-600/10 hover:border-emerald-600 text-emerald-600 hover:text-white"
              >
                <svg xmlns="http://www.w3.org/2000/svg" 
                  fill="currentColor" 
                  height="24" 
                  viewBox="0 0 24 24" 
                  width="24" 
                  focusable="false" 
                  aria-hidden="true" 
                  style="pointer-events: none; 
                  display: inherit; 
                  width: 100%; height: 100%;"
                >
                  <path 
                    clip-rule="evenodd" 
                    d="m14.302 6.457-.668-.278L12.87 3.5h-1.737l-.766 2.68-.668.277c-.482.2-.934.463-1.344.778l-.575.44-2.706-.677-.868 1.504 1.938 
                      2.003-.093.716c-.033.255-.05.514-.05.779 0 .264.017.524.05.779l.093.716-1.938 2.003.868 1.504 2.706-.677.575.44c.41.315.862.577 
                      1.344.778l.668.278.766 2.679h1.737l.765-2.68.668-.277c.483-.2.934-.463 1.345-.778l.574-.44 
                      2.706.677.869-1.504-1.938-2.003.092-.716c.033-.255.05-.514.05-.779 0-.264-.017-.524-.05-.779l-.092-.716 
                      1.938-2.003-.869-1.504-2.706.677-.574-.44c-.41-.315-.862-.577-1.345-.778Zm4.436.214Zm-3.86-1.6-.67-2.346c-.123-.429-.516-.725-.962-.725h-2.492c-.446 
                      0-.838.296-.961.725l-.67 2.347c-.605.251-1.17.58-1.682.972l-2.37-.593c-.433-.108-.885.084-1.108.47L2.717 8.08c-.223.386-.163.874.147 1.195l1.698 
                      1.755c-.04.318-.062.642-.062.971 0 .329.021.653.062.97l-1.698 1.756c-.31.32-.37.809-.147 1.195l1.246 2.158c.223.386.675.578 1.109.47l2.369-.593c.512.393 
                      1.077.72 1.681.972l.67 2.347c.124.429.516.725.962.725h2.492c.446 0 .839-.296.961-.725l.67-2.347c.605-.251 1.17-.58 1.682-.972l2.37.593c.433.108.885-.084 
                      1.109-.47l1.245-2.158c.223-.386.163-.874-.147-1.195l-1.698-1.755c.04-.318.062-.642.062-.971 0-.329-.021-.653-.062-.97l1.698-1.756c.31-.32.37-.809.147-1.195L20.038 
                      5.92c-.224-.386-.676-.578-1.11-.47l-2.369.593c-.512-.393-1.077-.72-1.681-.972ZM15.5 12c0 1.933-1.567 3.5-3.5 3.5S8.5 13.933 8.5 12s1.567-3.5 3.5-3.5 3.5 
                      1.567 3.5 3.5ZM14 12c0 1.105-.895 2-2 2s-2-.895-2-2 .895-2 2-2 2 .895 2 2Z" 
                    fill-rule="evenodd">
                  </path>
                </svg>
              </nuxt-link>
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
          <h5 class="text-xl font-semibold">{{ user ? user?.name : 'Mr. Calvin carlo' }}</h5>


          <div class="text-slate-400 mt-4">
            <p class="mb-2">
              {{ user?.bio[0] }}
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