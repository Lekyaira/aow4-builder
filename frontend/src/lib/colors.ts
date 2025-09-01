import { computed } from "vue";
import type { Aspect } from "@/api/types.gen";

export function aspectRing(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "ring-aspect-astral/30";
      break;
    }
    case "shadow": {
      return "ring-aspect-shadow/30";
      break;
    }
    case "chaos": {
      return "ring-aspect-chaos/30";
      break;
    }
    case "materium": {
      return "ring-aspect-materium/30";
      break;
    }
    case "nature": {
      return "ring-aspect-nature/30";
      break;
    }
    case "order": {
      return "ring-aspect-order/30";
      break;
    }
  }
}

export function aspectBg(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "bg-aspect-astral/15";
      break;
    }
    case "shadow": {
      return "bg-aspect-shadow/15";
      break;
    }
    case "chaos": {
      return "bg-aspect-chaos/15";
      break;
    }
    case "materium": {
      return "bg-aspect-materium/15";
      break;
    }
    case "nature": {
      return "bg-aspect-nature/15";
      break;
    }
    case "order": {
      return "bg-aspect-order/15";
      break;
    }
  }
}

export function aspectBgFrom(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "from-aspect-astral/40 aria-pressed:from-aspect-astral";
      break;
    }
    case "shadow": {
      return "from-aspect-shadow/40 aria-pressed:from-aspect-shadow";
      break;
    }
    case "chaos": {
      return "from-aspect-chaos/40 aria-pressed:from-aspect-chaos";
      break;
    }
    case "materium": {
      return "from-aspect-materium/40 aria-pressed:from-aspect-materium";
      break;
    }
    case "nature": {
      return "from-aspect-nature/40 aria-pressed:from-aspect-nature";
      break;
    }
    case "order": {
      return "from-aspect-order/40 aria-pressed:from-aspect-order";
      break;
    }
  }
}

export function aspectBgTo(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "to-aspect-astral/40 aria-pressed:to-aspect-astral";
      break;
    }
    case "shadow": {
      return "to-aspect-shadow/40 aria-pressed:to-aspect-shadow";
      break;
    }
    case "chaos": {
      return "to-aspect-chaos/40 aria-pressed:to-aspect-chaos";
      break;
    }
    case "materium": {
      return "to-aspect-materium/40 aria-pressed:to-aspect-materium";
      break;
    }
    case "nature": {
      return "to-aspect-nature/40 aria-pressed:to-aspect-nature";
      break;
    }
    case "order": {
      return "to-aspect-order/40 aria-pressed:to-aspect-order";
      break;
    }
  }
}

export function aspectText(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "text-aspect-astral";
      break;
    }
    case "shadow": {
      return "text-aspect-shadow";
      break;
    }
    case "chaos": {
      return "text-aspect-chaos";
      break;
    }
    case "materium": {
      return "text-aspect-materium";
      break;
    }
    case "nature": {
      return "text-aspect-nature";
      break;
    }
    case "order": {
      return "text-aspect-order";
      break;
    }
  }
}

export function aspectTextFrom(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "from-aspect-astral";
      break;
    }
    case "shadow": {
      return "from-aspect-shadow";
      break;
    }
    case "chaos": {
      return "from-aspect-chaos";
      break;
    }
    case "materium": {
      return "from-aspect-materium";
      break;
    }
    case "nature": {
      return "from-aspect-nature";
      break;
    }
    case "order": {
      return "from-aspect-order";
      break;
    }
  }
}

export function aspectTextTo(aspect: Aspect) {
  switch (aspect) {
    case "astral": {
      return "to-aspect-astral";
      break;
    }
    case "shadow": {
      return "to-aspect-shadow";
      break;
    }
    case "chaos": {
      return "to-aspect-chaos";
      break;
    }
    case "materium": {
      return "to-aspect-materium";
      break;
    }
    case "nature": {
      return "to-aspect-nature";
      break;
    }
    case "order": {
      return "to-aspect-order";
      break;
    }
  }
}

export function badgeAspect(aspect: Aspect | null) {
  switch (aspect) {
    case "astral": {
      return "!bg-aspect-astral/15 !text-aspect-astral";
      break;
    }
    case "shadow": {
      return "!bg-aspect-shadow/15 !text-aspect-shadow";
      break;
    }
    case "chaos": {
      return "!bg-aspect-chaos/15 !text-aspect-chaos";
      break;
    }
    case "materium": {
      return "!bg-aspect-materium/15 !text-aspect-materium";
      break;
    }
    case "nature": {
      return "!bg-aspect-nature/15 !text-aspect-nature";
      break;
    }
    case "order": {
      return "!bg-aspect-order/15 !text-aspect-order";
      break;
    }
    case null: {
      return "";
      break;
    }
  }
}
