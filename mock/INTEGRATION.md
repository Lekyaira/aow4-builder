# AoW4 Empire Builder — Integration Guide

This guide helps you integrate the mockup into a Vue 3 + Tailwind project. It includes a Tailwind theme, minimal global CSS, and Vue component snippets mirroring the mockup’s patterns.

## 1) Tailwind Setup

Add/extend your Tailwind config with the theme used in the mockup. If you’re using the CDN now, move to a local Tailwind build for production.

Example `tailwind.config.js`:

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    './index.html',
    './src/**/*.{vue,js,ts}',
    './components/**/*.{vue,js,ts}',
  ],
  safelist: [
    // Dynamic aspect classes used by components
    { pattern: /bg-aspect-(astral|shadow|chaos|materium|nature|order)\/10/ },
    { pattern: /text-aspect-(astral|shadow|chaos|materium|nature|order)/ },
    { pattern: /border-aspect-(astral|shadow|chaos|materium|nature|order)\/40/ },
    { pattern: /ring-aspect-(astral|shadow|chaos|materium|nature|order)\/30/ },
    { pattern: /from-aspect-(astral|shadow|chaos|materium|nature|order)/ },
    { pattern: /to-aspect-(astral|shadow|chaos|materium|nature|order)/ },
  ],
  theme: {
    extend: {
      colors: {
        aspect: {
          astral: '#0090C0', // deeper cyan
          shadow: '#7C3AED', // purple
          chaos: '#DC2626',  // red
          materium: '#EA580C', // orange
          nature: '#16A34A', // green
          order: '#EAB308',  // yellow
        },
        ink: { DEFAULT: '#1F2937', soft: '#334155' },
        parchment: { light: '#F8F5EB', tan: '#EDE6D6', edge: '#D9D2C2' },
      },
      boxShadow: { card: '0 2px 6px rgba(15, 23, 42, 0.12)' },
      borderRadius: { herald: '12px' },
      fontFamily: {
        display: ['Cinzel', 'serif'],
        sans: ['Inter', 'system-ui', 'ui-sans-serif'],
      },
    },
  },
};
```

Fonts: include `Cinzel` and `Inter` (e.g., Google Fonts) in your HTML or main entry.

## 2) Minimal Global CSS

Include `styles.css` (already in this repo) for parchment flourishes. It only adds `.decorate-card` and a subtle background noise.

```css
/* styles.css excerpt */
.decorate-card::before,
.decorate-card::after { /* … */ }
```

## 3) Dark Mode

- Class-based: add/remove `dark` on `<html>` or a container.
- You can persist preference via `localStorage` and a simple toggle (see `index.html`).

## 4) Vue Components

Snippets live under `components/`. Import and register locally or globally. All components are Vue 3 `<script setup>`.

### SectionCard
- Purpose: Shared parchment/heraldry container + optional header area.
- Accessibility: semantic `<section>` wrapper recommended; pass `aria-labelledby` as needed.

Usage:

```vue
<SectionCard>
  <template #header>
    <h2 class="font-display text-xl">Species</h2>
  </template>
  <!-- content here -->
  …
</SectionCard>
```

### SelectField
- Purpose: Labeled select with screen-reader-only label.
- Props: `id`, `label`, `modelValue`, `options: { value, label }[]`.
- Emits: `update:modelValue`.

Usage:

```vue
<SelectField
  id="species"
  label="Species"
  v-model="form.species"
  :options="[
    { value: 'human', label: 'Human' },
    { value: 'elfkin', label: 'Elfkin' },
  ]"
/>
```

### SelectorChip
- Purpose: Generic chip toggle with optional small badge (for trait cost or marker).
- Props: `modelValue` (boolean), `badge` (string|number|null), `disabled`.
- Emits: `update:modelValue`.

Usage:

```vue
<SelectorChip v-model="traitSelected" :badge="2">Adaptive</SelectorChip>
```

### TomeChip (single aspect)
- Purpose: Tome selector styled by a single aspect.
- Props: `modelValue`, `aspect`, `label`.
- Emits: `update:modelValue`.

Usage:

```vue
<TomeChip v-model="tomes.evocation" aspect="astral" label="Tome of Evocation" />
```

### TomeChipDual (two aspects)
- Purpose: Dual-aspect tome with gradient border and neutral inner background, gradient text.
- Props: `modelValue`, `aspectA`, `aspectB`, `label`.
- Emits: `update:modelValue`.

Usage:

```vue
<TomeChipDual
  v-model="tomes.starsVeils"
  aspectA="astral"
  aspectB="shadow"
  label="Tome of Stars & Veils"
/>
```

### AspectIndicator
- Purpose: Circular aspect indicator with sphere icon and numeric value.
- Props: `aspect`, `value`, `srLabel`, `size` ('sm'|'md').

Usage:

```vue
<AspectIndicator aspect="astral" :value="6" srLabel="Astral" size="sm" />
```

### AspectsLegend (optional)
- Purpose: Small legend showing the six aspect colors.

Usage:

```vue
<AspectsLegend class="mt-2" />
```

## 5) Accessibility Notes
- All interactive chips are implemented as buttons with `role="checkbox"` and `aria-checked` or as `<label><input type="checkbox"/></label>` depending on your preference. Pick one pattern consistently.
- Inputs use screen-reader-only labels; visible placeholders guide sighted users.
- Aspect indicators include `sr-only` labels so numbers are announced contextually (e.g., “Astral: 6”).

## 6) Theming and Colors
- Components reference Tailwind classes like `text-aspect-astral` or `ring-aspect-order/30`.
- When building for production, dynamic class names require Tailwind safelist (see config above).

## 7) Example Page Layout

```vue
<template>
  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
    <SectionCard>
      <template #header>
        <h2 class="font-display text-2xl">Aspects</h2>
      </template>
      <div class="grid grid-cols-3 md:grid-cols-6 gap-4">
        <AspectIndicator aspect="astral" :value="6" srLabel="Astral" />
        <AspectIndicator aspect="shadow" :value="3" srLabel="Shadow" />
        <AspectIndicator aspect="chaos" :value="4" srLabel="Chaos" />
        <AspectIndicator aspect="materium" :value="2" srLabel="Materium" />
        <AspectIndicator aspect="nature" :value="5" srLabel="Nature" />
        <AspectIndicator aspect="order" :value="1" srLabel="Order" />
      </div>
    </SectionCard>
  </main>
  <AspectsLegend class="mt-2" />
</template>
```

That’s it — adapt these snippets to your state management and data sources. If you want TypeScript props or a centralized color utility, I can add those next.

