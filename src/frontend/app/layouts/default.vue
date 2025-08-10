<script setup lang="ts">
</script>

<template>
  <div class="flex flex-col min-h-screen">
    <!-- Header -->
    <Navbar
        :container="'container'"
        :lightLogo="true"
        :lightNav="'!justify-end'"
    />

    <!-- Contenido -->
    <main class="flex-1">
      <slot />
    </main>

    <!-- Footer -->
    <Footer />

    <!-- Switcher -->
    <Switcher />
  </div>
</template>
