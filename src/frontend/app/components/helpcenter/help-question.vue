<template>
    <div v-for="item in datas" :key="item" class="relative shadow-sm dark:shadow-gray-800 rounded-md overflow-hidden mt-4 first:mt-0">
        <h2 class="text-base font-semibold" id="accordion-collapse-heading-1">
            <button type="button" @click="isActive = isActive === item.id ? null : item.id" :class="item.id === isActive ? 'bg-gray-50 text-emerald-600 dark:bg-slate-800' : ''" class="flex justify-between items-center p-5 w-full font-semibold text-start" data-accordion-target="#accordion-collapse-body-1" aria-expanded="true" aria-controls="accordion-collapse-body-1">
                <span>{{ item.name }}</span>
                <svg :class="item.id === isActive ? 'rotate-180' : ''" data-accordion-icon class="size-4 shrink-0" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </h2>
        <div id="accordion-collapse-body-1" :class="item.id === isActive ? '' : 'hidden'" aria-labelledby="accordion-collapse-heading-1">
            <div class="p-5">
                <p class="text-slate-400 dark:text-gray-400">{{ item.title }}</p>
            </div>
        </div>
    </div>
</template>

<script setup>

import { ref } from 'vue'

    const isActive = ref(1)

    const datas = [
        {
            id: 1,
            name: 'How does it work ?',
            title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
        },
        {
            id: 2,
            name: 'Do I need a designer to use Jobstack ?',
            title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
        },
        {
            id: 3,
            name: 'What do I need to do to start selling ?',
            title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
        },
        {
            id: 4,
            name: 'What happens when I receive an order ?',
            title: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'
        },
    ]
</script>

<style lang="scss" scoped></style>