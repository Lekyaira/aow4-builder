<script setup lang="ts">
import TitleBar from "@/components/TitleBar.vue";
import FooterInfo from "@/components/FooterInfo.vue";
</script>

<template>
  <a
    href="#main"
    class="sr-only focus:not-sr-only focus:absolute focus:top-2 focus:left-2 focus:z-50 bg-white/90 dark:bg-slate-800/90 px-3 py-1 rounded"
  >
    Skip to content
  </a>
  <TitleBar />
  <main id="main" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
    <Suspense>
      <RouterView />
      <template #fallback> Loading... </template>
    </Suspense>
  </main>
  <FooterInfo />
</template>
