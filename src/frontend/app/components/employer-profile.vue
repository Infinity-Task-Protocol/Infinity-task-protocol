<template>
            <div class="container mt-12">
                <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px]">
                    <div class="lg:col-span-8 md:col-span-7">
                        <h5 class="text-xl font-semibold">Company Story</h5>
                        <p class="text-slate-400 mt-4">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed.</p>
                        <p class="text-slate-400 mt-2">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage.</p>

                        <div class="grid grid-cols-12 gap-6 mt-6">
                            <div class="col-span-12">
                                <img :src="company1" class="rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                            </div>
                            <div class="col-span-6">
                                <img :src="company2" class="rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                            </div>
                            <div class="col-span-6">
                                <img :src="company3" class="rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" alt="">
                            </div>
                        </div>

                        <h5 class="text-xl font-semibold mt-6">Vacancies:</h5>

                        <div class="grid lg:grid-cols-2 grid-cols-1 gap-6 mt-6">
                            <div class="group relative overflow-hidden rounded-md shadow-sm dark:shadow-gray-800">
                                <div class="p-6">
                                    <router-link to="#" class="title h5 text-lg font-semibold hover:text-emerald-600">Software Engineering</router-link>
                                    <p class="text-slate-400 mt-2"><i class="uil uil-clock text-emerald-600"></i> Posted 3 Days ago</p>
        
                                    <div class="flex justify-between items-center mt-4">
                                        <span class="bg-emerald-600/5 text-emerald-600 text-xs font-bold px-2.5 py-0.5 rounded h-5">Full Time</span>
                                        <p class="text-slate-400"><i class="uil uil-usd-circle text-emerald-600"></i> $950 - $1100/mo</p>
                                    </div>
                                </div>
        
                                <div class="flex items-center p-6 border-t border-gray-100 dark:border-gray-800">
                                    <img :src="logo1" class="size-12 shadow-md dark:shadow-gray-800 rounded-md p-2 bg-white dark:bg-slate-900" alt="">
        
                                    <div class="ms-3">
                                        <h6 class="mb-0 font-semibold text-base">Skype</h6>
                                        <span class="text-slate-400 text-sm">Australia</span>
                                    </div>
                                </div>
                            </div>
        
                            <div class="group relative overflow-hidden rounded-md shadow-sm dark:shadow-gray-800">
                                <div class="p-6">
                                    <router-link to="#" class="title h5 text-lg font-semibold hover:text-emerald-600">Web Developer</router-link>
                                    <p class="text-slate-400 mt-2"><i class="uil uil-clock text-emerald-600"></i> Posted 3 Days ago</p>
        
                                    <div class="flex justify-between items-center mt-4">
                                        <span class="bg-emerald-600/5 text-emerald-600 text-xs font-bold px-2.5 py-0.5 rounded h-5">Remote</span>
                                        <p class="text-slate-400"><i class="uil uil-usd-circle text-emerald-600"></i> $2500 - $2600/mo</p>
                                    </div>
                                </div>
        
                                <div class="flex items-center p-6 border-t border-gray-100 dark:border-gray-800">
                                    <img :src="logo1" class="size-12 shadow-md dark:shadow-gray-800 rounded-md p-2 bg-white dark:bg-slate-900" alt="">
        
                                    <div class="ms-3">
                                        <h6 class="mb-0 font-semibold text-base">Skype</h6>
                                        <span class="text-slate-400 text-sm">America</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="p-6 rounded-md shadow-sm dark:shadow-gray-800 mt-8">
                            <h5 class="text-xl font-semibold">Leave A Comment:</h5>

                            <form class="mt-8">
                                <div class="grid lg:grid-cols-12 lg:gap-6">
                                    <div class="lg:col-span-6 mb-5">
                                        <div class="text-start">
                                            <label for="name" class="font-semibold">Your Name:</label>
                                            <div class="form-icon relative mt-2">
                                                <i data-feather="user" class="size-4 absolute top-3 start-4"></i>
                                                <input name="name" id="name" type="text" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded h-10 outline-none bg-transparent !ps-11" placeholder="Name :">
                                            </div>
                                        </div>
                                    </div>
    
                                    <div class="lg:col-span-6 mb-5">
                                        <div class="text-start">
                                            <label for="email" class="font-semibold">Your Email:</label>
                                            <div class="form-icon relative mt-2">
                                                <i data-feather="mail" class="size-4 absolute top-3 start-4"></i>
                                                <input name="email" id="email" type="email" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded h-10 outline-none bg-transparent !ps-11" placeholder="Email :">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1">
                                    <div class="mb-5">
                                        <div class="text-start">
                                            <label for="comments" class="font-semibold">Your Comment:</label>
                                            <div class="form-icon relative mt-2">
                                                <i data-feather="message-circle" class="size-4 absolute top-3 start-4"></i>
                                                <textarea name="comments" id="comments" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded h-10 outline-none bg-transparent !ps-11 h-28" placeholder="Message :"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="submit" id="submit" name="send" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white rounded-md w-full">Send Message</button>
                            </form>
                        </div>
                    </div>
                    
                    <div class="lg:col-span-4 md:col-span-5">
                        <div class="bg-slate-50 dark:bg-slate-800 rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 sticky top-20">
                            <div class="w-full leading-[0] border-0">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d39206.002432144705!2d-95.4973981212445!3d29.709510002925988!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8640c16de81f3ca5%3A0xf43e0b60ae539ac9!2sGerald+D.+Hines+Waterwall+Park!5e0!3m2!1sen!2sin!4v1566305861440!5m2!1sen!2sin" style="border:0" class="w-full h-[350px] rounded-md shadow-sm shadow-gray-200 dark:shadow-gray-700" allowfullscreen></iframe>
                            </div>

                            <ul class="list-none mt-4">
                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Founded:</span>
                                    <span class="font-medium">2003</span>
                                </li>

                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Founder:</span>
                                    <span class="font-medium">Niklas Zennström</span>
                                </li>

                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Headquarters:</span>
                                    <span class="font-medium">Luxembourg</span>
                                </li>

                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Number of employees:</span>
                                    <span class="font-medium">788</span>
                                </li>

                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Website:</span>
                                    <span class="font-medium">https://skype.com</span>
                                </li>
                                
                                <li class="flex justify-between mt-2">
                                    <span class="text-slate-400 font-medium">Social:</span>

                                    <ul class="list-none text-end space-x-0.5">
                                        <li class="inline"><a href="https://dribbble.com/shreethemes" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                                        <li class="inline"><a href="https://www.behance.net/shreethemes" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-behance" title="Behance"></i></a></li>
                                        <li class="inline"><a href="http://linkedin.com/company/shreethemes" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-linkedin" title="Linkedin"></i></a></li>
                                        <li class="inline"><a href="https://www.facebook.com/shreethemes" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                                        <li class="inline"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                                        <li class="inline"><a href="https://twitter.com/shreethemes" target="_blank" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                                        <li class="inline"><a href="mailto:support@shreethemes.in" class="size-8 inline-flex items-center text-center justify-center text-base font-semibold tracking-wide align-middle transition duration-500 ease-in-out border-2 border-gray-200 dark:border-gray-700 rounded-md hover:border-emerald-600 dark:hover:border-emerald-600 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white dark:text-white text-slate-400"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                                    </ul>
                                </li>
                            </ul>

                            <div class="mt-4 pt-2 border-t border-gray-200 dark:border-gray-800">
                                <h5 class="text-lg font-semibold">Contact us</h5>

                                <form>
                                    <div class="grid grid-cols-1 gap-2">
                                        <div>
                                            <label for="name2" class="font-semibold">Your Name:</label>
                                            <input name="name" id="name2" type="text" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Name :">
                                        </div>
        
                                        <div>
                                            <label for="email2" class="font-semibold">Your Email:</label>
                                            <input name="email" id="email2" type="email" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Email :">
                                        </div>
    
                                        <div>
                                            <label for="subject" class="font-semibold">Your Question:</label>
                                            <input name="subject" id="subject" class="form-input border border-slate-100 dark:border-slate-800 mt-2" placeholder="Subject :">
                                        </div>
    
                                        <div>
                                            <label for="comments2" class="font-semibold">Your Comment:</label>
                                            <textarea name="comments" id="comments2" class="form-input border border-slate-100 dark:border-slate-800 mt-2 textarea" placeholder="Message :"></textarea>
                                        </div>
                                    </div>
                                    <button type="submit" id="submit2" name="send" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 text-white rounded-md">Send Message</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</template>

<script setup>
import company1 from '@/assets/images/company/1.jpg'
import company2 from '@/assets/images/company/2.jpg'
import company3 from '@/assets/images/company/3.jpg'
import logo1 from '@/assets/images/company/skype.png'
    
</script>

<style lang="scss" scoped>

</style>