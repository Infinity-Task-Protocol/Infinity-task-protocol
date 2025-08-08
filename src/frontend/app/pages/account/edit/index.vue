<script setup lang="ts">
import { ref } from 'vue'

definePageMeta({
  middleware: ['auth'],
})

const session = useSessionStore()

const form = ref({
  name: '',
  email: '',
  position: '',
  bio: '',
  skills: [] as string[],
  socialLinks: [] as string[],
  avatar: null as File | null,
  coverImage: null as File | null,
})

function handleAvatar(e: Event) {
  const input = e.target as HTMLInputElement
  form.value.avatar = input.files?.[0] ?? null
}

function handleCoverImage(e: Event) {
  const input = e.target as HTMLInputElement
  form.value.coverImage = input.files?.[0] ?? null
}

async function fileToUint8Array(file: File | null): Promise<[] | number[]> {
  if (!file) return []
  const buffer = await file.arrayBuffer()
  return Array.from(new Uint8Array(buffer))
}

async function handleSubmit() {
  const avatarBytes = await fileToUint8Array(form.value.avatar)
  const coverImageBytes = await fileToUint8Array(form.value.coverImage)

  const payload = {
    name: form.value.name ? [form.value.name] : [],
    email: form.value.email ? [form.value.email] : [],
    position: form.value.position ? [form.value.position] : [],
    bio: form.value.bio ? [form.value.bio] : [],
    skills: form.value.skills,
    socialLinks: form.value.socialLinks,
    avatar: avatarBytes.length > 0 ? [avatarBytes] : [],
    coverImage: coverImageBytes.length > 0 ? [coverImageBytes] : [],
  }

  const res = await session.backend.editProfile(payload)
  navigateTo("/account")
}
</script>

<template>
  <section class="bg-slate-50 dark:bg-slate-800 py-16 lg:py-24">
    <div class="container">
      <div class="max-w-3xl mx-auto">
        <div class="p-6 bg-white dark:bg-slate-900 shadow-sm rounded-md">
          <form class="text-start" @submit.prevent="handleSubmit">
            <h5 class="text-lg font-semibold mb-4">Profile Information</h5>

            <div class="grid grid-cols-1 gap-4">
              <div>
                <label class="font-semibold">Name:</label>
                <input v-model="form.name" type="text" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Email:</label>
                <input v-model="form.email" type="email" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Position:</label>
                <input v-model="form.position" type="text" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Bio:</label>
                <textarea v-model="form.bio" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Skills:</label>
                <UInputTags v-model="form.skills" placeholder="Add skill" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Social Links:</label>
                <UInputTags v-model="form.socialLinks" placeholder="Add link" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Avatar:</label>
                <input type="file" @change="handleAvatar" class="form-input mt-1 border" />
              </div>

              <div>
                <label class="font-semibold">Cover Image:</label>
                <input type="file" @change="handleCoverImage" class="form-input mt-1 border" />
              </div>

              <div class="pt-4">
                <button
                    type="submit"
                    class="py-2 px-4 font-semibold text-white bg-emerald-600 rounded-md hover:bg-emerald-700 transition"
                >
                  Save Profile
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>
