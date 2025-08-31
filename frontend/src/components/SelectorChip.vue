<script setup lang="ts">
const props = defineProps<{
  value: boolean;
  badgeClass?: string;
  disabled?: boolean;
}>();
const emit = defineEmits(["update:value"]);

function clicked() {
  if (props.disabled) return;
  emit("update:value");
}
</script>

<template>
  <button
    type="button"
    role="checkbox"
    :aria-pressed="value ? 'true' : 'false'"
    :disabled="disabled"
    @click="clicked"
    class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full border border-parchment-edge/70 dark:border-slate-700 bg-white/70 dark:bg-slate-800/70 text-sm shadow-sm select-none transition hover:-translate-y-0.5 focus:outline-none focus:ring-2 focus:ring-aspect-astral/60 disabled:opacity-30 aria-pressed:bg-aspect-astral/30"
  >
    <span
      v-if="$slots.badge"
      :class="[
        'inline-grid place-items-center text-[11px] leading-none w-5 h-5 rounded-full bg-parchment-tan/70 dark:bg-slate-700 text-ink/80 dark:text-slate-100 ring-1 ring-black/5',
        badgeClass,
      ]"
      ><slot name="badge"
    /></span>
    <slot />
  </button>
</template>
