<script setup lang="ts">
import { ref, onMounted } from 'vue'

definePageMeta({
  middleware: [
    'auth',
  ],
});

const session = useSessionStore()
const router = useRouter()
// Estado de registro
const isRegister = ref(session.user != null)

// Estado del stepper (0 = registro, 1 = verificación)
const currentStep = ref(0)

// Formularios
const registerForm = ref({ name: '' })
const verificationForm = ref({ code: '' })

// Estado de carga
const isRegistering = ref(false)
const isVerifying = ref(false)
const isGettingCode = ref(false)

function nextStep() {
  if (currentStep.value < 1) currentStep.value++
}
// function prevStep() {
//   if (currentStep.value > 0) currentStep.value--
// }

// Manejo de registro
async function handleRegister() {
  try {
    isRegistering.value = true
    
    isRegister.value = "Ok" in await session.backend.signUp({ name: registerForm.value.name })
    nextStep()
  } catch (e) {
    console.error('Registration error', e)
  } finally {
    isRegistering.value = false
  }
}

// Obtener código
async function getVerificationCode() {
  try {
    isGettingCode.value = true
    const code = await session.backend.getVerificationCode()
    console.log(code)
  } catch (e) {
    console.error('Error getting code', e)
  } finally {
    isGettingCode.value = false

  }
}

// Manejo de verificación
async function handleVerification() {
  let res = false
  try {
    isVerifying.value = true
    res = await session.backend.enterCodeVerification(BigInt(verificationForm.value.code))
  } catch (e) {
    console.error("Verification error", e)
  } finally {
    isVerifying.value = false
    console.log("finally",res)
    if (res) await router.push('/')
  }
}

// Saltar registro si ya está registrado
onMounted(() => {
  if (isRegister.value) currentStep.value = 1
})
</script>

<template>
  <section class="relative bg-slate-50 dark:bg-slate-800 lg:py-24 py-16 block mt-20">
    <div class="container">
      <div class="lg:flex justify-center">
        <div class="lg:w-2/3">
          <div class="p-6 bg-white dark:bg-slate-900 shadow-sm rounded-md">

            <!-- Indicador de pasos -->
            <div class="flex justify-between mb-6">
              <div class="flex-1 text-center" :class="currentStep === 0 ? 'font-bold' : 'text-gray-400'">
                1. Register
              </div>
              <div class="flex-1 text-center" :class="currentStep === 1 ? 'font-bold' : 'text-gray-400'">
                2. Verify
              </div>
            </div>

            <!-- Paso 1: Registro -->
            <div v-if="currentStep === 0 && !isRegister" class="space-y-4">
              <form @submit.prevent="handleRegister">
                <h5 class="text-lg font-semibold">Register</h5>
                <label class="block font-semibold">Name:</label>
                <input
                    v-model="registerForm.name"
                    type="text"
                    class="w-full border px-3 py-2 rounded-md"
                    placeholder="Enter your name"
                    required
                />
                <button
                    type="submit"
                    :disabled="isRegistering || !registerForm.name.trim()"
                    class="mt-4 py-2 px-4 text-white bg-emerald-600 hover:bg-emerald-700 rounded-md disabled:opacity-50"
                >
                  <span v-if="isRegistering">Registering...</span>
                  <span v-else>Register</span>
                </button>
              </form>
            </div>

            <!-- Paso 2: Verificación -->
            <div v-if="currentStep === 1" class="space-y-4">
              <form @submit.prevent="handleVerification">
                <h5 class="text-lg font-semibold">Verify Your Account</h5>
                <label class="block font-semibold">Verification Code:</label>
                <input
                    v-model="verificationForm.code"
                    type="text"
                    class="w-full border px-3 py-2 rounded-md"
                    placeholder="Enter verification code"
                    required
                />
                <div class="flex gap-2 mt-4">
                  <button
                      type="button"
                      @click="getVerificationCode"
                      :disabled="isGettingCode"
                      class="py-2 px-4 text-white bg-blue-600 hover:bg-blue-700 rounded-md disabled:opacity-50"
                  >
                    <span v-if="isGettingCode">Getting Code...</span>
                    <span v-else>Get Verification Code</span>
                  </button>
                  <button
                      type="submit"
                      :disabled="isVerifying || !verificationForm.code.trim()"
                      class="py-2 px-4 text-white bg-emerald-600 hover:bg-emerald-700 rounded-md disabled:opacity-50"
                  >
                    <span v-if="isVerifying">Verifying...</span>
                    <span v-else>Verify Code</span>
                  </button>
                </div>
              </form>
            </div>



          </div>
        </div>
      </div>
    </div>
  </section>
</template>
