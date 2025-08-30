import { computed, type WritableComputedRef } from "vue";

export function useChipSelector<T, K extends string | number>(opts: {
  items: () => readonly T[]; // getter so it stays reactive
  getId: (t: T) => K; // how to identify each item
  isSelected: (id: K) => boolean; // check store selection
  add: (item: T) => void | Promise<void>; // add action (store)
  remove: (id: K) => void | Promise<void>; // remove action (store)
}) {
  function modelFor(item: T): WritableComputedRef<boolean> {
    const id = opts.getId(item);
    return computed<boolean>({
      get: () => opts.isSelected(id),
      set: (checked) => {
        if (checked) opts.add(item);
        else opts.remove(id);
      },
    });
  }
  return { modelFor };
}
