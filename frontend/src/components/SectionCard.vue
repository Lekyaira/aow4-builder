<script setup lang="ts">
const { compact = false } = defineProps<{
  ariaLabelledby?: string;
  compact?: boolean;
}>();
</script>

<template>
  <section
    class="relative overflow-hidden p-4 sm:p-6 shadow-card decorate-card"
    :class="[
      compact
        ? '!pt-1 !pb-1'
        : 'rounded-herald border border-parchment-edge/70 dark:border-slate-700 bg-gradient-to-br from-white/80 to-parchment-tan/40 dark:from-slate-800/80 dark:to-slate-800/40',
    ]"
    :aria-labelledby="ariaLabelledby"
  >
    <header v-if="$slots.header" :class="[compact ? '' : 'mb-4']">
      <slot name="header" />
    </header>
    <div class="space-y-4">
      <slot />
    </div>
  </section>
</template>
