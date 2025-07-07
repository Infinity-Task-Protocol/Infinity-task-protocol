<template>
    <div class="grid md:grid-cols-12 grid-cols-1 gap-[30px] mx-auto text-center">
        <div class="lg:col-start-3 lg:col-span-8 md:col-start-2 md:col-span-10">
            <div class="bg-white dark:bg-slate-900 rounded-md shadow-sm dark:shadow-gray-800 p-6">
                <form>
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
                                <label for="subject" class="font-semibold">Your Question:</label>
                                <div class="form-icon relative mt-2">
                                    <i data-feather="book" class="size-4 absolute top-3 start-4"></i>
                                    <input name="subject" id="subject" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded h-10 outline-none bg-transparent !ps-11" placeholder="Subject :">
                                </div>
                            </div>
                        </div>

                        <div class="mb-5">
                            <div class="text-start">
                                <label for="comments" class="font-semibold">Your Comment:</label>
                                <div class="form-icon relative mt-2">
                                    <i data-feather="message-circle" class="size-4 absolute top-3 start-4"></i>
                                    <textarea name="comments" id="comments" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded outline-none bg-transparent !ps-11 h-28" placeholder="Message :"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" id="submit" name="send" class="btn border-emerald-600 bg-emerald-600 hover:bg-emerald-700 hover:border-emerald-700 text-white rounded-md justify-center flex items-center">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script setup>
</script>

<style lang="scss" scoped></style>