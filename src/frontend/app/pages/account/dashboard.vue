<template>
  <div class="container mx-auto px-6 pt-50 pb-12">
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <UCard>
        <div class="flex items-center gap-4">
          <UIcon name="i-heroicons-currency-dollar-20-solid" class="w-8 h-8 text-primary-500 dark:text-primary-400" />
          <div>
            <p class="text-gray-500 dark:text-gray-400">Available Balance</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ balance }} ICP</p>
          </div>
        </div>
      </UCard>

      <UCard>
        <div class="flex items-center gap-4">
          <UIcon name="i-heroicons-banknotes-20-solid" class="w-8 h-8 text-primary-500 dark:text-primary-400" />
          <div>
            <p class="text-gray-500 dark:text-gray-400">Total Earnings</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ totalEarnings }} ICP</p>
          </div>
        </div>
      </UCard>

      <UCard>
        <div class="flex items-center gap-4">
          <UIcon name="i-heroicons-arrow-down-tray-20-solid" class="w-8 h-8 text-primary-500 dark:text-primary-400" />
          <div>
            <p class="text-gray-500 dark:text-gray-400">Total Withdrawals</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ totalWithdrawals }} ICP</p>
          </div>
        </div>
      </UCard>

      <UCard>
        <div class="flex items-center gap-4">
          <UIcon name="i-heroicons-clock-20-solid" class="w-8 h-8 text-primary-500 dark:text-primary-400" />
          <div>
            <p class="text-gray-500 dark:text-gray-400">Pending Payments</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ pendingPayments }} ICP</p>
          </div>
        </div>
      </UCard>
    </div>

    ---

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mt-12">
      <UCard class="lg:col-span-1">
        <template #header>
          <h3 class="text-xl font-bold text-gray-900 dark:text-white">Withdraw Funds</h3>
        </template>

        <UForm :state="withdrawalState" class="space-y-4" @submit="handleWithdrawal">
          <UFormGroup label="Amount to withdraw (ICP)" name="amount" :hint="`Max: ${balance} ICP`">
            <UInput type="number" v-model="withdrawalState.amount" placeholder="e.g. 50.00" :min="1" :max="balance" />
          </UFormGroup>

          <UFormGroup label="Wallet Address" name="address">
            <UInput v-model="withdrawalState.address" placeholder="Enter your wallet address" />
            <template #hint>
              <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                Please ensure the address is correct. Withdrawals are irreversible.
              </p>
            </template>
          </UFormGroup>

          <UButton type="submit" block :disabled="!withdrawalState.amount || !withdrawalState.address">
            Withdraw Funds
          </UButton>
        </UForm>
        <UAlert v-if="withdrawalMessage" :title="withdrawalMessage.title" :description="withdrawalMessage.description" :color="withdrawalMessage.color" class="mt-4" />
      </UCard>

      <UCard class="lg:col-span-2">
        <template #header>
          <div class="flex items-center justify-between">
            <h3 class="text-xl font-bold text-gray-900 dark:text-white">Completed Tasks History</h3>
            <UButton icon="i-heroicons-arrow-path-20-solid" size="sm" variant="ghost" @click="fetchTasks" />
          </div>
        </template>

        <UTable :rows="completedTasks" :columns="columns" />
      </UCard>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// Dashboard state and data (These values will come from your actual backend)
const balance = ref(125.50);
const totalEarnings = ref(580.75);
const totalWithdrawals = ref(455.25);
const pendingPayments = ref(0.00);

// Withdrawal form state
const withdrawalState = ref({
  amount: null,
  address: '',
});

// Withdrawal message state
const withdrawalMessage = ref(null);

// Function to handle the withdrawal
const handleWithdrawal = () => {
  withdrawalMessage.value = null;

  // Validation logic
  if (withdrawalState.value.amount > balance.value) {
    withdrawalMessage.value = {
      title: 'Withdrawal Error',
      description: 'The withdrawal amount cannot exceed your available balance.',
      color: 'red'
    };
    return;
  }

  if (!withdrawalState.value.address) {
    withdrawalMessage.value = {
      title: 'Withdrawal Error',
      description: 'Please enter a valid wallet address.',
      color: 'red'
    };
    return;
  }

  // Here you would add the real logic to interact with your ICP canister
  console.log(`Withdrawing ${withdrawalState.value.amount} ICP to address: ${withdrawalState.value.address}`);

  // Simulate a success message
  withdrawalMessage.value = {
    title: 'Withdrawal in progress!',
    description: `A withdrawal of ${withdrawalState.value.amount} ICP has been requested. The transaction is being processed.`,
    color: 'green'
  };

  // Clear the form after a successful withdrawal
  withdrawalState.value.amount = null;
  withdrawalState.value.address = '';
};

// Columns for the task history table (CORRECTED with 'key')
const columns = [
  { key: 'taskId', id: 'taskId', label: 'Task ID' },
  { key: 'description', id: 'description', label: 'Description' },
  { key: 'payment', id: 'payment', label: 'Payment Amount (ICP)' },
  { key: 'completionDate', id: 'completionDate', label: 'Completion Date' }
];

// Sample data for the table (replace with real data from your backend)
const completedTasks = ref([
  { taskId: 'TASK-001', description: 'Landing page development', payment: 50.00, completionDate: '2025-07-28' },
  { taskId: 'TASK-002', description: 'Smart contract implementation', payment: 150.00, completionDate: '2025-08-01' },
  { taskId: 'TASK-003', description: 'Canister code review', payment: 75.50, completionDate: '2025-08-05' },
  { taskId: 'TASK-004', description: 'Dashboard UI creation', payment: 100.25, completionDate: '2025-08-08' },
]);

// Function to refresh the history data
const fetchTasks = () => {
  console.log('Refreshing task history...');
  // This is where your backend call to fetch tasks would go
};
</script>

<style scoped>
/* No additional styles needed as Tailwind handles everything */
</style>