<template>
    <div class="shadow-sm shadow-gray-200 dark:shadow-gray-700 rounded-md bg-white dark:bg-slate-900 sticky top-20">
        <div class="p-6">
            <h5 class="text-lg font-semibold">Job Information</h5>
        </div>
        <div class="p-6 border-t border-slate-100 dark:border-t-gray-700">
            <ul class="list-none">
                <li class="flex items-center">
                    <i data-feather="user-check" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Employee Type:</p>
                        <span class="text-emerald-600 font-medium text-sm">{{data?.type ? data?.type : 'Full Time'}}</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="map-pin" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Location:</p>
                        <span class="text-emerald-600 font-medium text-sm">{{data?.country ? data?.country : 'Beijing, China'}}</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="monitor" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Job Type:</p>
                        <span class="text-emerald-600 font-medium text-sm">{{data?.job ? data?.job : 'Back-end Developer'}}</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="briefcase" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Experience:</p>
                        <span class="text-emerald-600 font-medium text-sm">2+ years</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="book" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Qualifications:</p>
                        <span class="text-emerald-600 font-medium text-sm">MCA</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="dollar-sign" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Salary:</p>
                        <span class="text-emerald-600 font-medium text-sm">$4000 - $4500</span>
                    </div>
                </li>

                <li class="flex items-center mt-3">
                    <i data-feather="clock" class="size-5"></i>

                    <div class="ms-4">
                        <p class="font-medium">Date posted:</p>
                        <span class="text-emerald-600 font-medium text-sm">28th Feb, 2023</span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import logo1 from '@/assets/images/company/facebook-logo.png'
import logo2 from '@/assets/images/company/google-logo.png'
import logo3 from '@/assets/images/company/android.png'
import logo4 from '@/assets/images/company/lenovo-logo.png'
import logo5 from '@/assets/images/company/spotify.png'
import logo6 from '@/assets/images/company/linkedin.png'
import logo7 from '@/assets/images/company/circle-logo.png'
import logo8 from '@/assets/images/company/skype.png'
import logo9 from '@/assets/images/company/snapchat.png'
import logo10 from '@/assets/images/company/shree-logo.png'
import logo11 from '@/assets/images/company/telegram.png'
import logo12 from '@/assets/images/company/whatsapp.png'

const route = useRoute()

const id = ref('')
const data = ref(null)

const datas = [
  {
    id: 1,
    image: logo1,
    name: 'Facebook',
    day: '2 days ago',
    type: 'Full Time',
    job: 'Web Designer / Developer',
    country: 'Australia',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 2,
    image: logo2,
    name: 'Google',
    day: '2 days ago',
    type: 'Part Time',
    job: 'Marketing Director',
    country: 'USA',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 3,
    image: logo3,
    name: 'Android',
    day: '2 days ago',
    type: 'Remote',
    job: 'Application Developer',
    country: 'China',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 4,
    image: logo4,
    name: 'Lenovo',
    day: '2 days ago',
    type: 'WFH',
    job: 'Senior Product Designer',
    country: 'Dubai',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 5,
    image: logo5,
    name: 'Spotify',
    day: '2 days ago',
    type: 'Full Time',
    job: 'C++ Developer',
    country: 'India',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 6,
    image: logo6,
    name: 'Linkedin',
    day: '2 days ago',
    type: 'Remote',
    job: 'Php Developer',
    country: 'Pakistan',
    vacancy: '21 applied',
    vacancy2: 'of 40 vacancy'
  },
  {
    id: 7,
    image: logo7,
    name: 'Circle CI',
    job: 'Web Designer / Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 8,
    image: logo8,
    name: 'Skype',
    job: 'Marketing Director',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 9,
    image: logo9,
    name: 'Snapchat',
    job: 'Application Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 10,
    image: logo10,
    name: 'Shreethemes',
    job: 'Senior Product Designer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 11,
    image: logo11,
    name: 'Telegram',
    job: 'C++ Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  },
  {
    id: 12,
    image: logo12,
    name: 'Whatsapp',
    job: 'Php Developer',
    title: 'Looking for an experienced Web Designer for an our company.',
    type: 'Full Time',
    salary: '$4,000 - $4,500',
    location: 'Australia'
  }
]

onMounted(() => {
  id.value = route.params.id
  data.value = datas.find(item => item.id === parseInt(id.value))
})
</script>

<style lang="scss" scoped></style>