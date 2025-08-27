<template>
  <section
    class="relative overflow-hidden rounded-herald border border-parchment-edge/70 dark:border-slate-700 bg-gradient-to-br from-white/80 to-parchment-tan/40 dark:from-slate-800/80 dark:to-slate-800/40 p-4 sm:p-6 shadow-card decorate-card"
    :aria-labelledby="ariaLabelledby"
  >
    <header v-if="$slots.header" class="mb-4">
      <slot name="header" />
    </header>
    <slot />
  </section>
</template>

<script setup lang="ts">
defineProps<{ ariaLabelledby?: string }>()
</script>

