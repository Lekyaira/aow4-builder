<script setup lang="ts">
import SpeciesFormsCombo from "@/components/SpeciesFormsCombo.vue";
import TextField from "@/components/TextField.vue";
import { useEmpireStore } from "@/stores/empire";

const empireStore = useEmpireStore();
</script>
<template>
  <h1>Welcome</h1>
  <TextField v-model="empireStore.name" placeholder="Empire Name" />
  <SpeciesFormsCombo v-model="empireStore.speciesForm" />
</template>
