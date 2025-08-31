<script setup lang="ts">
import { computed } from "vue";
import type { Aspect } from "@/api/types.gen";
import { aspectRing, aspectBg, aspectText } from "@/lib/colors";
import { AspectIcon } from "@/icons";

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
        <AspectIcon />
      </span>
      <span class="sr-only">{{ srLabel }}: </span>
      <span>{{ value }}</span>
    </div>
  </div>
</template>
