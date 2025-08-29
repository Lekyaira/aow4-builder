<script setup lang="ts">
import { computed } from "vue";
import type { Aspect } from "@/api/types.gen";
import { aspectRing, aspectBg, aspectText } from "@/lib/colors";

const props = defineProps<{
  aspect: Aspect;
  value: number;
  srLabel: string;
}>();
</script>

<template>
  <div
    role="listitem"
    class="min-h-[50px] sm:min-h-[75px] lg:min-h-[80px] max-h-[100px] sm:max-h-[120px] lg:max-h-[130px] relative isolate grid place-items-center text-center rounded-full aspect-square bg-white/75 dark:bg-slate-800/70 ring-2 shadow-card"
    :class="aspectRing(aspect)"
  >
    <div
      class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full ring-1 ring-black/5 shadow-sm text-base font-semibold"
      :class="[aspectBg(aspect), aspectText(aspect)]"
    >
      <span class="grid place-items-center w-5 h-5" aria-hidden="true">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 16 16"
          width="1em"
          height="1em"
        >
          <path
            fill="currentColor"
            fill-rule="evenodd"
            d="M13.5 8a5.5 5.5 0 1 1-11 0a5.5 5.5 0 0 1 11 0M15 8A7 7 0 1 1 1 8a7 7 0 0 1 14 0M8 4a.75.75 0 0 0 0 1.5A2.5 2.5 0 0 1 10.5 8A.75.75 0 1 0 12 8a4 4 0 0 0-4-4"
            clip-rule="evenodd"
          ></path>
        </svg>
      </span>
      <span class="sr-only">{{ srLabel }}: </span>
      <span>{{ value }}</span>
    </div>
  </div>
</template>
