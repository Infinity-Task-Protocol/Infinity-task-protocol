<template>
    <div class="lg:col-span-4 md:col-span-6">
        <div class="shadow-sm shadow-gray-200 dark:shadow-gray-700 p-6 rounded-md bg-white dark:bg-slate-900 sticky top-20">
            <form>
                <div class="grid grid-cols-1 gap-3">
                    <div>
                        <label for="searchname" class="font-semibold">Search Company</label>
                        <div class="relative mt-2">
                            <i class="uil uil-search text-lg absolute top-[5px] start-3"></i>
                            <input name="search" id="searchname" type="text" class="w-full py-2 px-3 text-[14px] border border-gray-200 dark:border-gray-800 dark:bg-slate-900 dark:text-slate-200 rounded h-10 outline-none bg-transparent ps-10" placeholder="Search">
                        </div>
                    </div>
                    
                    <div>
                        <label class="font-semibold">Categories</label>
                        <select class="form-select form-input border border-slate-100 dark:border-slate-800 block w-full mt-1">
                            <option value="WD">Web Designer</option>
                            <option value="WD">Web Developer</option>
                            <option value="UI">UI / UX Desinger</option>
                        </select>
                    </div>

                    <div>
                        <label class="font-semibold">Location</label>
                        <select class="form-select form-input border border-slate-100 dark:border-slate-800 block w-full mt-1">
                            <option value="MDQ">Mar del Plata</option>
                                    <option value="BSAS">Buenos Aires</option>
                                    <option value="STG">Santiago</option>
                                    <option value="STC">Santa Cruz</option>
                        </select>
                    </div>
                    
                    <div>
                        <label class="font-semibold">Job Types</label>
                        <div class="block mt-2">
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="fulltime">
                                    <label class="form-checkbox-label text-slate-400" for="fulltime">Full Time</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">3</span>
                            </div>
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="parttime">
                                    <label class="form-checkbox-label text-slate-400" for="parttime">Part Time</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">7</span>
                            </div>
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="Freelancing">
                                    <label class="form-checkbox-label text-slate-400" for="Freelancing">Freelancing</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">4</span>
                            </div>
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="fixedprice">
                                    <label class="form-checkbox-label text-slate-400" for="fixedprice">Fixed Price</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">6</span>
                            </div>
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="Remote">
                                    <label class="form-checkbox-label text-slate-400" for="Remote">Remote</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">7</span>
                            </div>
                            <div class="flex justify-between">
                                <div class="inline-flex items-center mb-0">
                                    <input class="form-checkbox size-4 appearance-none rounded border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" type="checkbox" value="" id="hourlybasis">
                                    <label class="form-checkbox-label text-slate-400" for="hourlybasis">Hourly Basis</label>
                                </div>

                                <span class="bg-emerald-600/10 text-emerald-600 text-xs px-2.5 py-0.5 font-semibold rounded-full h-5">44</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <label class="font-semibold">Salary</label>
                        <div class="block mt-2">
                            <div>
                                <label class="inline-flex items-center">
                                    <input type="radio" class="form-radio size-4 appearance-none rounded-full border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" name="radio-colors" value="1" checked>
                                    <span class="text-slate-400">10k - 15k</span>
                                </label>
                            </div>
                            <div>
                                <label class="inline-flex items-center">
                                    <input type="radio" class="form-radio size-4 appearance-none rounded-full border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" name="radio-colors" value="1">
                                    <span class="text-slate-400">15k - 25k</span>
                                </label>
                            </div>
                            <div>
                                <label class="inline-flex items-center">
                                    <input type="radio" class="form-radio size-4 appearance-none rounded-full border border-gray-200 dark:border-gray-800 accent-green-600 checked:appearance-auto dark:accent-green-600 focus:border-green-300 focus:ring-0 focus:ring-offset-0 focus:ring-green-200 focus:ring-opacity-50 me-2" name="radio-colors" value="1">
                                    <span class="text-slate-400">more than 25K</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div>
                        <input type="submit" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white rounded-md w-full" value="Apply Filter">
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
   
</script>

<style lang="scss" scoped>

</style>