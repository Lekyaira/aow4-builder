<template>
  <button
    type="button"
    role="checkbox"
    :aria-checked="modelValue ? 'true' : 'false'"
    @click="$emit('update:modelValue', !modelValue)"
    class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full border text-sm shadow-sm select-none transition hover:-translate-y-0.5 focus:outline-none focus:ring-2 focus:ring-aspect-astral/60"
    :class="[
      `border-aspect-${aspect}/40`,
      `text-aspect-${aspect}`,
      `bg-aspect-${aspect}/10`,
    ]"
  >
    {{ label }}
  </button>
</template>

<script setup lang="ts">
type Aspect = 'astral'|'shadow'|'chaos'|'materium'|'nature'|'order'
defineProps<{ modelValue: boolean; aspect: Aspect; label: string }>()
defineEmits<{ (e: 'update:modelValue', value: boolean): void }>()
</script>

