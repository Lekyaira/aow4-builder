<script setup lang="ts">
import { ref, computed } from "vue";
import TextField from "@/components/TextField.vue";
import SectionCard from "@/components/SectionCard.vue";
import AspectIndicator from "@/components/AspectIndicator.vue";
import SelectField from "@/components/SelectField.vue";
import SelectorChip from "@/components/SelectorChip.vue";
import { useEmpireStore } from "@/stores/empire";
import type { Culture, SpeciesForm, SpeciesTrait } from "@/api/types.gen";
import { cultures, speciesForms, speciesTraits } from "@/api/sdk.gen";
import { toOptions, fromValue } from "@/lib/selectAdapter";
import { useChipSelector } from "@/lib/useChipSelector";

const empireStore = useEmpireStore();
const { data: culturesData, culturesErrorText } = await cultures();
const { data: speciesFormsData, speciesFormsErrorText } = await speciesForms();
const { data: speciesTraitsData, speciesTraitsErrorText } =
  await speciesTraits();

// Options for cultures select field
const cultureOptions = computed(() =>
  toOptions<Culture>(
    culturesData,
    (f) => f.id,
    (f) => f.name,
  ),
);
// Wire cultures v-model via computed setter/getter
const culturesModel = computed<number | null>({
  get: () => empireStore.culture?.id ?? null,
  set: (val) => {
    const selected = fromValue(culturesData, val, (f) => f.id);
    empireStore.culture = selected;
  },
});

// Options for species forms select field
const speciesFormsOptions = computed(() =>
  toOptions<SpeciesForm>(
    speciesFormsData,
    (f) => f.id,
    (f) => f.name,
  ),
);
// Wire species forms v-model via computed setter/getter
const speciesFormsModel = computed<number | null>({
  get: () => empireStore.speciesForm?.id ?? null,
  set: (val) => {
    const selected = fromValue(speciesFormsData, val, (f) => f.id);
    empireStore.speciesForm = selected;
  },
});
// Wire species traits v-model via computed boolean
const { modelFor: speciesTraitsModel } = useChipSelector<SpeciesTrait, number>({
  items: () => speciesTraitsData,
  getId: (t) => t.id,
  isSelected: (id) => empireStore.speciesTraits.some((t) => t.id === id),
  add: (t) => {
    empireStore.addSpeciesTrait(t);
  },
  remove: (id) => {
    empireStore.removeSpeciesTrait(id);
  },
});
</script>

<template>
  <!-- Empire Name -->
  <section aria-labelledby="empire-name" class="mb-6">
    <div
      class="relative overflow-hidden rounded-herald border border-parchment-edge/70 dark:border-slate-700 bg-gradient-to-br from-white/80 to-parchment-tan/40 dark:from-slate-800/80 dark:to-slate-800/40 p-4 sm:p-6 shadow-card decorate-card"
    >
      <div class="flex flex-col sm:flex-row sm:items-end gap-3">
        <div class="flex-1">
          <label for="empire" id="empire-name" class="sr-only"
            >Empire Name</label
          >
          <TextField
            id="empire"
            name="empire"
            v-model="empireStore.name"
            placeholder="Name your empire..."
          />
        </div>
      </div>
    </div>
  </section>
  <!-- Aspects -->
  <div class="mb-6">
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Aspects</h2>
      </template>
      <div
        class="grid grid-cols-3 md:grid-cols-6 gap-4"
        role="list"
        aria-label="Aspect totals"
      >
        <AspectIndicator
          aspect="astral"
          :value="empireStore.astralValue"
          srLabel="Astral"
        />
        <AspectIndicator
          aspect="shadow"
          :value="empireStore.shadowValue"
          srLabel="Shadow"
        />
        <AspectIndicator
          aspect="chaos"
          :value="empireStore.chaosValue"
          srLabel="Chaos"
        />
        <AspectIndicator
          aspect="materium"
          :value="empireStore.materiumValue"
          srLabel="Materium"
        />
        <AspectIndicator
          aspect="nature"
          :value="empireStore.natureValue"
          srLabel="Nature"
        />
        <AspectIndicator
          aspect="order"
          :value="empireStore.orderValue"
          srLabel="Order"
        />
      </div>
    </SectionCard>
  </div>
  <!-- Two-column responsive form layout -->
  <section class="grid grid-cols-1 lg:grid-cols-2 gap-6">
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Species</h2>
      </template>
      <SelectField
        id="species-forms"
        label="Species Forms"
        :options="speciesFormsOptions"
        :modelValue="speciesFormsModel"
        @update:modelValue="speciesFormsModel = $event"
      />
      <fieldset>
        <legend class="text-sm font-medium text-ink-soft dark:text-slate-300">
          Traits
          <span class="text-xs ms-1"
            >({{ empireStore.speciesTraitPoints }})</span
          >
        </legend>
        <div
          class="mt-2 flex flex-wrap gap-2"
          role="group"
          aria-label="Species traits"
        >
          <!-- Trait chips -->
          <SelectorChip
            v-for="t in speciesTraitsData"
            :key="t.id"
            :modelValue="speciesTraitsModel(t).value"
            @update:modelValue="(val) => (speciesTraitsModel(t).value = val)"
            :badge="t.cost"
            :disabled="
              empireStore.speciesTraitPoints < t.cost &&
              !speciesTraitsModel(t).value
            "
          >
            {{ t.name }}
          </SelectorChip>
        </div>
      </fieldset>
    </SectionCard>
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Culture</h2>
      </template>
      <SelectField
        id="cultures"
        label="Cultures"
        :options="cultureOptions"
        :modelValue="culturesModel"
        @update:modelValue="culturesModel = $event"
      />
    </SectionCard>
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Ruler</h2>
      </template>
    </SectionCard>
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Tomes</h2>
      </template>
    </SectionCard>
  </section>
</template>
