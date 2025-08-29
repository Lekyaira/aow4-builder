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
