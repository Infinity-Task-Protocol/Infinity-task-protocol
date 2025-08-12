<template>
  <div>
    <section class="bg-gray-50 dark:bg-gray-900 py-24 sm:py-32 lg:pb-40">
      <div class="mx-auto max-w-7xl px-6 lg:px-8">
        <div class="mx-auto max-w-2xl text-center">
          <h1
              class="text-4xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl"
          >
            Infinity Tasks Protocol
          </h1>
          <p class="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300">
            A fully on-chain freelance service platform on the Internet Computer (ICP).
          </p>
          <div class="mt-10 flex items-center justify-center gap-x-6">
            <UButton
                to="#"
                size="xl"
                label="Get Started"
                icon="i-heroicons-arrow-right-20-solid"
                trailing
            />
            <UButton
                to="https://github.com/Infinity-Task-Protocol/Infinity-task-protocol/blob/main/Whitepaper.md"
                size="xl"
                variant="ghost"
                label="Read Whitepaper"
            />
          </div>
        </div>
      </div>
    </section>

    <section class="bg-white dark:bg-gray-800 py-24">
      <div class="container mx-auto px-6">
        <h2 class="text-3xl font-bold text-center text-gray-900 dark:text-white">
          🚨 The Problem
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mt-12">
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-currency-dollar-20-solid"
                    class="w-6 h-6 text-red-500"
                />
                <h3 class="text-xl font-bold">Excessive Commission Rates</h3>
              </div>
            </template>
            <p>
              Total fees often range from <strong>20% to 40%</strong>, including
              platform charges and payment processing cuts.
            </p>
          </UCard>
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-clock-20-solid"
                    class="w-6 h-6 text-red-500"
                />
                <h3 class="text-xl font-bold">Holding Periods</h3>
              </div>
            </template>
            <p>
              Freelancers frequently face <strong>delays</strong> before
              receiving their earnings.
            </p>
          </UCard>
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-credit-card-20-solid"
                    class="w-6 h-6 text-red-500"
                />
                <h3 class="text-xl font-bold">High Withdrawal Costs</h3>
              </div>
            </template>
            <p>
              Especially in underbanked regions, withdrawal costs can be
              significant.
            </p>
          </UCard>
        </div>
      </div>
    </section>

    <section class="bg-gray-50 dark:bg-gray-900 py-24">
      <div class="container mx-auto px-6">
        <h2 class="text-3xl font-bold text-center text-gray-900 dark:text-white">
          💡 Our Solution
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mt-12">
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-receipt-percent-20-solid"
                    class="w-6 h-6 text-primary-500"
                />
                <h3 class="text-xl font-bold">Fair Commissions</h3>
              </div>
            </template>
            <p>
              Between <strong>5% and 12%</strong>, all-in, to ensure freelancers
              get more of what they earn.
            </p>
          </UCard>
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-bolt-20-solid"
                    class="w-6 h-6 text-primary-500"
                />
                <h3 class="text-xl font-bold">Instant Payouts</h3>
              </div>
            </template>
            <p>
              No more waiting. Freelancers get paid <strong>instantly</strong>
              upon approval of their work.
            </p>
          </UCard>
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-wallet-20-solid"
                    class="w-6 h-6 text-primary-500"
                />
                <h3 class="text-xl font-bold">Crypto-Native</h3>
              </div>
            </template>
            <p>
              Leverage the power of <strong>ICP tokens</strong> for fast and
              secure payments.
            </p>
          </UCard>
          <UCard>
            <template #header>
              <div class="flex items-center gap-2">
                <UIcon
                    name="i-heroicons-lock-closed-20-solid"
                    class="w-6 h-6 text-primary-500"
                />
                <h3 class="text-xl font-bold">Fully On-Chain</h3>
              </div>
            </template>
            <p>
              All logic is built into smart contracts (canisters) for
              <strong>full transparency</strong>.
            </p>
          </UCard>
        </div>
      </div>
    </section>

    <section class="bg-white dark:bg-gray-800 py-24">
      <div class="container mx-auto px-6">
        <h2 class="text-3xl font-bold text-center text-gray-900 dark:text-white">
          🔁 How It Works
        </h2>
        <div class="mt-12 max-w-3xl mx-auto">
          <UAccordion :items="steps" multiple>
            <template #item="{ item }">
              <p class="text-gray-500 dark:text-gray-400 text-base">
                {{ item.content }}
              </p>
            </template>
          </UAccordion>
        </div>
      </div>
    </section>

    <section class="py-24">
      <div class="container mx-auto px-6">
        <UCard
            class="bg-primary-500 dark:bg-primary-600 text-white text-center p-12"
        >
          <h2 class="text-3xl font-bold">
            Ready to join the future of freelance?
          </h2>
          <p class="mt-4 text-lg">
            Experience low fees, instant payouts, and full transparency.
          </p>
          <UButton
              to="#"
              size="xl"
              color="white"
              class="mt-8"
          >
            Get Started Now
          </UButton>
        </UCard>
      </div>
    </section>



  </div>
</template>

<script setup>
const steps = [
  {
    label: 'Task Publishing',
    icon: 'i-heroicons-document-text-20-solid',
    content: 'A client publishes a task, including a description and a price range.'
  },
  {
    label: 'Freelancer Offers',
    icon: 'i-heroicons-light-bulb-20-solid',
    content: 'Freelancers can submit offers with their proposed fee within the specified range.'
  },
  {
    label: 'Offer Acceptance & Payment',
    icon: 'i-heroicons-hand-thumb-up-20-solid',
    content: 'The client accepts an offer and sends ICP tokens to a dedicated subaccount.'
  },
  {
    label: 'Work Delivery & Approval',
    icon: 'i-heroicons-check-circle-20-solid',
    content: 'The freelancer submits the task, which the client reviews and approves.'
  },
  {
    label: 'Funds Release & Withdrawal',
    icon: 'i-heroicons-wallet-20-solid',
    content: 'Upon approval, the escrow is released and the freelancer can withdraw their earnings at any time.'
  }
];

useHead({
  title: 'Infinity Tasks Protocol - On-Chain Freelance Platform',
  meta: [
    {
      name: 'description',
      content: 'A fully on-chain freelance platform on the Internet Computer (ICP) with low fees and instant payouts.'
    }
  ]
});
</script>