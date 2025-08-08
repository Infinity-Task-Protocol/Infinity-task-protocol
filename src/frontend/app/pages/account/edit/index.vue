<script setup lang="ts">
import { ref } from 'vue'
import {compressAndConvertImage, blobToImageUrl, uint8ArrayToBase64 } from "../../../utils/imageManager"

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
  avatar: [] as Uint8Array[],
  thumbnail: [] as Uint8Array[],
  coverImage: [] as Uint8Array[],
})

if (session.user) {
  form.value.name = session.user.name;
  form.value.email = session.user.email[0]? session.user.email[0]: "";
  form.value.bio = session.user.bio[0] ? session.user.bio[0] : ""
  form.value.position = session.user.position[0]? session.user.position[0] : "";
  form.value.skills = session.user.skills;
  form.value.socialLinks = session.user.socialLinks;
  form.value.avatar = session.user.avatar as Uint8Array[];
  form.value.thumbnail = session.user.thumbnail as Uint8Array[];
  form.value.coverImage = session.user.coverImage as Uint8Array[];
}
const handleFileUpload = async (event: Event) => {
  const file = (event.target as HTMLInputElement).files?.[0];
  if (file) {
    form.value.avatar = [await compressAndConvertImage(file, 500, 1000, 1000)]
    form.value.thumbnail = [await compressAndConvertImage(file, 50, 150, 150)]
  }
};

const handleCoverImage = async (e: Event) => {
  const file = (e.target as HTMLInputElement).files?.[0];
  if (file) {
    form.value.coverImage = [await compressAndConvertImage(file, 700, 1200, 1200)]
  }
}

async function handleSubmit() {

  const payload = {
    name: form.value.name ? [form.value.name] : [],
    email: form.value.email ? [form.value.email] : [],
    position: form.value.position ? [form.value.position] : [],
    bio: [form.value.bio.trim()],
    skills: form.value.skills,
    socialLinks: form.value.socialLinks,
    avatar: form.value.avatar,
    coverImage: form.value.coverImage,
    thumbnail: form.value.thumbnail,
  }

  const res = await session.backend.editProfile(payload)
  if ("Ok" in res) {
    session.user = res.Ok
  }
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
                <input type="file" @change="handleFileUpload" class="form-input mt-1 border" />
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
