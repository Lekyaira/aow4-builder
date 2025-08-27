<template>
  <div>
    <label :for="id" class="sr-only">{{ label }}</label>
    <select
      :id="id"
      class="mt-1 w-full bg-white dark:bg-slate-800 border border-parchment-edge/70 dark:border-slate-700 rounded-herald px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-aspect-order/70"
      :value="modelValue"
      @change="$emit('update:modelValue', ($event.target as HTMLSelectElement).value)"
    >
      <option v-for="opt in options" :key="opt.value" :value="opt.value">
        {{ opt.label }}
      </option>
    </select>
  </div>
</template>

<script setup lang="ts">
interface Option { value: string | number; label: string }
defineProps<{
  id: string
  label: string
  modelValue: string | number | null
  options: Option[]
}>()
defineEmits<{ (e: 'update:modelValue', value: string | number): void }>()
</script>

