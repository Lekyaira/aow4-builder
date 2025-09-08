<script setup lang="ts">
import { useEmpireStore } from "@/stores/empire";

const store = useEmpireStore();

async function copyShareUrl() {
  const url = store.toShareUrl();
  await navigator.clipboard.writeText(url);
  // TODO: Show a toast message
}
</script>

<template>
  <button class="btn" @click="copyShareUrl">Copy Build</button>
</template>
