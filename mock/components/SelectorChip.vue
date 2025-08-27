<template>
  <button
    type="button"
    role="checkbox"
    :aria-checked="modelValue ? 'true' : 'false'"
    :disabled="disabled"
    @click="$emit('update:modelValue', !modelValue)"
    class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full border border-parchment-edge/70 dark:border-slate-700 bg-white/70 dark:bg-slate-800/70 text-sm shadow-sm select-none transition hover:-translate-y-0.5 focus:outline-none focus:ring-2 focus:ring-aspect-astral/60 disabled:opacity-60"
  >
    <span v-if="badge != null" class="inline-grid place-items-center text-[11px] leading-none w-5 h-5 rounded-full bg-parchment-tan/70 dark:bg-slate-700 text-ink/80 dark:text-slate-100 ring-1 ring-black/5">{{ badge }}</span>
    <slot />
  </button>
</template>

<script setup lang="ts">
defineProps<{ modelValue: boolean; badge?: string | number | null; disabled?: boolean }>()
defineEmits<{ (e: 'update:modelValue', value: boolean): void }>()
</script>

