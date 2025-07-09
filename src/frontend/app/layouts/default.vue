<script setup lang="ts">
</script>

<template>
  <Navbar :container="'container'" :lightLogo=true :lightNav="'!justify-end'" />
  <slot />
  <Footer/>
  <Switcher />
</template>