<script setup lang="ts">
import { useRouter, useRoute } from "vue-router";
import { ref, reactive } from "vue";

const route = useRoute();
const router = useRouter();
</script>

<template>
  <!-- Nav bar -->
  <header class="absolute top-0 left-0 w-full">
    <div class="mx-4 my-2 border-b">
      <nav class="flex">
        <!-- Nav links -->
        <div class="mx-1 my-2 px-1 border-2 rounded-md hover:border-teal-300">
          <RouterLink
            to="/"
            class="transition-colors hover:text-teal-300"
            :class="{ 'text-teal-400 font-semibold': route.path === '/' }"
          >
            Home
          </RouterLink>
        </div>
        <!-- End Nav links -->
      </nav>
    </div>
  </header>
  <!-- End Nav bar -->
</template>
