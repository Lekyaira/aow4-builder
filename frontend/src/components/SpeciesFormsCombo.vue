<script setup lang="ts">
import { ref, defineModel } from "vue";
import { speciesForms } from "@/api/sdk.gen";

const model = defineModel(1);
const { data: forms, errorText } = await speciesForms();
</script>

<template>
  <div class="m-1">
    <label for="species-forms" class="mr-1">Species Forms</label>
    <div v-if="errorText" class="text-red-600">{{ errorText }}</div>
    <select v-else name="species-forms" v-model="model">
      <option v-for="form in forms" :key="form.id" :value="form.id">
        {{ form.name }}
      </option>
    </select>
  </div>
</template>
