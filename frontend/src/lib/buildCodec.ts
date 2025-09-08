import {
  compressToEncodedURIComponent,
  decompressFromEncodedURIComponent,
} from "lz-string";
import { BUILD_VERSION } from "@/stores/empire";
import type { EmpireState } from "@/stores/empire";

type PayloadV1 = {
  v: 1;
  d: EmpireState;
};

type AnyPayload = PayloadV1;

/** Convert current store state -> compact, URL-safe string */
export function encodeBuild(state: EmpireState): string {
  const payload: AnyPayload = { v: BUILD_VERSION as 1, d: state };
  const json = JSON.stringify(payload);
  return compressToEncodedURIComponent(json);
}

/** Convert URL-safe string -> store state (with migrations if needed) */
export function decodeBuild(s: string): EmpireState | null {
  try {
    const json = decompressFromEncodedURIComponent(s);
    if (!json) return null;
    const payload = JSON.parse(json) as AnyPayload;

    switch (payload.v) {
      case 1: {
        // If you later add fields, migrate here
        return payload.d;
      }
      default:
        // Unknown version → ignore
        return null;
    }
  } catch {
    return null;
  }
}
