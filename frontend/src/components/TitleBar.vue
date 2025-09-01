<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from "vue";

const titleRef = ref<HTMLElement | null>(null);
const compactTitle = ref(false);
const enterSentinel = ref<HTMLElement | null>(null);
const exitSentinel = ref<HTMLElement | null>(null);

function setTitleHeightVar() {
  const h = titleRef.value?.offsetHeight ?? 0;
  document.documentElement.style.setProperty("--title-h", `${h}px`);
  // Let others know the height changed
  window.dispatchEvent(new CustomEvent("title-height-change", { detail: h }));
}

onMounted(() => {
  // Keep --title-h updated as header compacts/expands
  const ro = new ResizeObserver(setTitleHeightVar);
  if (titleRef.value) ro.observe(titleRef.value);
  setTitleHeightVar();
  window.addEventListener("resize", setTitleHeightVar, { passive: true });

  // IO #1: Enter sentinel (above header)
  // If it's visible, we're at/past the top -> expand
  const ioEnter = new IntersectionObserver(
    ([entry]) => {
      if (compactTitle.value) {
        if (entry) compactTitle.value = !entry.isIntersecting;
      }
    },
    { threshold: 0 },
  );

  // IO #2: Exit sentinel (below header)
  // When it leaves the viewport (not intersecting), compact.
  const ioExit = new IntersectionObserver(
    ([entry]) => {
      if (!compactTitle.value) {
        if (entry)
          compactTitle.value = !entry.isIntersecting || compactTitle.value;
      }
    },
    { threshold: 0 },
  );

  if (enterSentinel.value) ioEnter.observe(enterSentinel.value);
  if (exitSentinel.value) ioExit.observe(exitSentinel.value);

  // Initialize state (in case we load scrolled)
  // If enter is above the viewport, it won't be intersecting -> compact
  if (enterSentinel.value) {
    const top = enterSentinel.value.getBoundingClientRect().top;
    compactTitle.value = top < 0;
  }

  onBeforeUnmount(() => {
    ro.disconnect();
    ioEnter.disconnect();
    ioExit.disconnect();
    window.removeEventListener("resize", onResize);
  });
});

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
  <div ref="enterSentinel" class="h-0" />
  <header
    id="titleBar"
    ref="titleRef"
    class="top-0 z-50 backdrop-blur supports-[backdrop-filter]:bg-white/70 bg-white/90 dark:bg-slate-900/75 border-b border-parchment-edge/60 dark:border-slate-700"
    :class="compactTitle ? 'sticky' : ''"
  >
    <div
      class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center gap-3"
      :class="compactTitle ? 'py-1' : 'py-3'"
    >
      <div
        v-if="!compactTitle"
        class="w-8 h-8 rounded-full bg-gradient-to-br from-parchment-tan to-parchment-edge dark:from-slate-700 dark:to-slate-800 grid place-items-center ring-1 ring-black/5"
      >
        <span aria-hidden="true" class="text-xs">⚜️</span>
      </div>
      <h1
        class="font-display tracking-wide"
        :class="compactTitle ? 'text-base' : 'text-xl sm:text-2xl'"
      >
        Empire Builder
      </h1>
      <div v-if="!compactTitle" class="ms-auto flex items-center gap-2">
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
  <div ref="exitSentinel" class="h-0" />
</template>
