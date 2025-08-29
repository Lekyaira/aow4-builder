<script setup lang="ts">
function toggleTheme() {
  const root = document.documentElement;
  const isDark = root.classList.contains("dark");
  const next = isDark ? "light" : "dark";
  root.classList.toggle("dark", next === "dark");
  root.style.colorScheme = next;
  localStorage.setItem("theme", next);
}
</script>

<template>
  <header
    class="sticky top-0 z-40 backdrop-blur supports-[backdrop-filter]:bg-white/70 bg-white/90 dark:bg-slate-900/75 border-b border-parchment-edge/60 dark:border-slate-700"
  >
    <div
      class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 flex items-center gap-3"
    >
      <div
        class="w-8 h-8 rounded-full bg-gradient-to-br from-parchment-tan to-parchment-edge dark:from-slate-700 dark:to-slate-800 grid place-items-center ring-1 ring-black/5"
      >
        <span aria-hidden="true" class="text-xs">⚜️</span>
      </div>
      <h1 class="font-display text-xl sm:text-2xl tracking-wide">
        Empire Builder
      </h1>
      <div class="ms-auto flex items-center gap-2">
        <button
          id="themeToggle"
          type="button"
          class="inline-flex items-center gap-2 rounded-md border border-parchment-edge/70 dark:border-slate-700 px-3 py-1.5 text-sm shadow-sm hover:bg-white/60 dark:hover:bg-slate-800/60"
          aria-label="Toggle dark mode"
          @click="toggleTheme"
        >
          <span class="block dark:hidden" aria-hidden="true">🌙</span>
          <span class="hidden dark:block" aria-hidden="true">☀️</span>
          <span class="hidden sm:inline">Theme</span>
        </button>
      </div>
    </div>
  </header>
</template>
