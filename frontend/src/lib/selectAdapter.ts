export type Option = { value: string | number; label: string };

export function toOptions<T>(
  items: T[],
  getValue: (t: T) => string | number,
  getLabel: (t: T) => string,
): Option[] {
  return items.map((i) => ({ value: getValue(i), label: getLabel(i) }));
}

export function fromValue<T>(
  items: T[],
  value: string | number | null | undefined,
  getValue: (t: T) => string | number,
): T | null {
  if (value == null) return null;
  const v =
    typeof value === "string" && /^\d+$/.test(value) ? Number(value) : value;
  return items.find((i) => getValue(i) === v) ?? null;
}
