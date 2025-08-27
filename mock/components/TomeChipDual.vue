<template>
  <!-- Gradient border wrapper with neutral inner background and gradient text -->
  <button
    type="button"
    role="checkbox"
    :aria-checked="modelValue ? 'true' : 'false'"
    @click="$emit('update:modelValue', !modelValue)"
    class="relative inline-flex rounded-full p-[1px] text-sm select-none transition hover:-translate-y-0.5 shadow-sm focus:outline-none focus:ring-2"
    :class="[
      `from-aspect-${aspectA}`,
      `to-aspect-${aspectB}`,
      'bg-gradient-to-r',
      // focus ring uses the second aspect for visibility
      `focus:ring-aspect-${aspectB}/60`,
    ]"
  >
    <span class="inline-flex items-center gap-2 rounded-full px-3 py-1.5 bg-white/80 dark:bg-slate-800/70">
      <span :class="[`bg-gradient-to-r`, `from-aspect-${aspectA}`, `to-aspect-${aspectB}`, 'bg-clip-text text-transparent font-semibold']">{{ label }}</span>
    </span>
  </button>
</template>

<script setup lang="ts">
type Aspect = 'astral'|'shadow'|'chaos'|'materium'|'nature'|'order'
defineProps<{ modelValue: boolean; aspectA: Aspect; aspectB: Aspect; label: string }>()
defineEmits<{ (e: 'update:modelValue', value: boolean): void }>()
</script>

