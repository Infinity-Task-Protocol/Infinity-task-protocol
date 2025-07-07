<template>
    <div class="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-[30px]">
        <div  v-for="item in guidesData" :key="item" class="">
            <h5 class="font-semibold text-xl">{{ item.title }}</h5>
            <ul v-for="features in item.features" :key="features" class="list-none mt-4">
                <li class="mt-2"><router-link to="#" class="text-slate-400"><i class="mdi mdi-arrow-right text-emerald-600 me-2"></i>{{ features }}</router-link></li>
            </ul>
        </div>
    </div>
</template>

<script setup>
const guidesData = [
    {
        title: 'Getting started',
        features: [
            'Deciding to purchase', 'List your space', 'Landing an experience or adventure', 'Top uses questions'
        ]
    },
    {
        title: 'Your calendar',
        features: [
            'Pricing & availability', 'Booking settings', 'Responding to enquiries & requests', 'Snoozing or deactivating your listing'
        ]
    },
    {
        title: 'Your listings',
        features: [
            'Updating your listing', 'Neighbourhoods', 'Listing photos & photography', 'Cartzio Plus', 'API-connected software'
        ]
    },
    {
        title: 'How payouts work',
        features: [
            'Getting paid', 'Adding payout info', 'Your payout status', 'Donations', 'Taxes'
        ]
    },
    {
        title: 'Your reservations',
        features: [
            'Cartzio safely', 'Cartzio Experiences and Adventures', 'Changing a reservation', 'Cancelling a reservation', 'Long-term reservations'
        ]
    },
    {
        title: 'Reservation help',
        features: [
            'Help with a reservation or guest', 'Guest cancellations'
        ]
    },
    {
        title: 'Your account',
        features: [
            'Your profile', 'Account security', 'Identification & verifications', 'Reviews', 'Superhost status'
        ]
    }
]
</script>

<style lang="scss" scoped></style>