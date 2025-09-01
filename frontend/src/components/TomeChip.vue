<script setup lang="ts">
import { Tome, Aspect } from "@/api/types.gen";
import {
  aspectBgFrom,
  aspectBgTo,
  aspectTextFrom,
  aspectTextTo,
} from "@/lib/colors";

const props = defineProps<{
  value: boolean;
  tome: Tome;
  disabled?: boolean;
}>();
const emit = defineEmits(["update:value"]);

function clicked() {
  if (props.disabled) return;
  emit("update:value");
}

function ring(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "ring-aspect-astral/60 focus:ring-aspect-astral/60";
      break;
    }
    case "shadow": {
      return "ring-aspect-shadow/60 focus:ring-aspect-shadow/60";
      break;
    }
    case "chaos": {
      return "ring-aspect-chaos/60 focus:ring-aspect-chaos/60";
      break;
    }
    case "materium": {
      return "ring-aspect-materium/60 focus:ring-aspect-materium/60";
      break;
    }
    case "nature": {
      return "ring-aspect-nature/60 focus:ring-aspect-nature/60";
      break;
    }
    case "order": {
      return "ring-aspect-order/60 focus:ring-aspect-order/60";
      break;
    }
  }
}
</script>

<template>
  <!-- Gradient border wrapper with neutral inner background and gradient text -->
  <button
    type="button"
    role="checkbox"
    :aria-pressed="value ? 'true' : 'false'"
    :disabled="disabled"
    @click="clicked"
    class="relative inline-flex rounded-full p-[1px] text-sm select-none transition hover:-translate-y-0.5 shadow-sm focus:outline-none focus:ring-2 disabled:opacity-30 aria-pressed:ring-2"
    :class="[
      'bg-gradient-to-r',
      aspectBgFrom(tome.aspects[0]),
      aspectBgTo(tome.aspects[1]),
      ring(tome.aspects[0]),
    ]"
  >
    <span
      class="inline-flex items-center gap-2 rounded-full px-3 py-1.5 bg-white/80 dark:bg-slate-800/70"
    >
      <span
        class="bg-gradient-to-r bg-clip-text text-transparent"
        :class="[
          aspectTextFrom(tome.aspects[0]),
          aspectTextTo(tome.aspects[1]),
        ]"
        >{{ tome.name }}</span
      >
    </span>
  </button>
</template>
