<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount } from "vue";
import TextField from "@/components/TextField.vue";
import SectionCard from "@/components/SectionCard.vue";
import AspectIndicator from "@/components/AspectIndicator.vue";
import SelectField from "@/components/SelectField.vue";
import SelectorChip from "@/components/SelectorChip.vue";
import TomeChip from "@/components/TomeChip.vue";
import { useEmpireStore } from "@/stores/empire";
import type {
  Culture,
  CultureTrait,
  SpeciesForm,
  SpeciesTrait,
  Ruler,
  Tome,
} from "@/api/types.gen";
import {
  cultures,
  cultureTraits,
  speciesForms,
  speciesTraits,
  rulerTypes,
  tomes,
} from "@/api/sdk.gen";
import { toOptions, fromValue } from "@/lib/selectAdapter";
import { useChipSelector } from "@/lib/useChipSelector";
import { badgeAspect } from "@/lib/colors";
import { AspectIcon } from "@/icons";

const empireStore = useEmpireStore();
const { data: culturesData, culturesErrorText } = await cultures();
const { data: speciesFormsData, speciesFormsErrorText } = await speciesForms();
const { data: speciesTraitsData, speciesTraitsErrorText } =
  await speciesTraits();
const { data: cultureTraitsData, cultureTraitsErrorText } =
  await cultureTraits();
const { data: rulerTypesData, rulerTypesErrorText } = await rulerTypes();
const { data: tomesData, tomesErrorText } = await tomes();

// TODO: Should probable move these to a generic utility class
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

// Options for ruler types select field
const rulerTypesOptions = computed(() =>
  toOptions<Ruler>(
    rulerTypesData,
    (f) => f.id,
    (f) => f.name,
  ),
);
// Wire ruler types v-model via computed setter/getter
const rulerTypesModel = computed<number | null>({
  get: () => empireStore.rulerType?.id ?? null,
  set: (val) => {
    const selected = fromValue(rulerTypesData, val, (f) => f.id);
    empireStore.rulerType = selected;
  },
});

const compactAspects = ref(false);
const aspectsSentinel = ref<HTMLElement | null>(null);
let aspectsIO: IntersectionObserver | null = null;

function readTitleH(): number {
  return (
    parseInt(
      getComputedStyle(document.documentElement).getPropertyValue("--title-h"),
    ) || 56
  );
}

function setupAspectsObserver() {
  // (Re)create with current header height
  if (aspectsIO) {
    aspectsIO.disconnect();
    aspectsIO = null;
  }

  const titleH = readTitleH();
  aspectsIO = new IntersectionObserver(
    ([entry]) => {
      // robust across browsers
      compactAspects.value = !entry.isIntersecting;
    },
    {
      threshold: 0,
      // trigger line sits just under the header
      rootMargin: `-${titleH}px 0px 0px 0px`,
    },
  );
  if (aspectsSentinel.value) aspectsIO.observe(aspectsSentinel.value);
}

onMounted(() => {
  setupAspectsObserver();

  // Rebuild when TitleBar reports height change
  const onTitleHChange = () => setupAspectsObserver();
  window.addEventListener(
    "title-height-change",
    onTitleHChange as EventListener,
  );

  // As a fallback, also rebuild on window resize
  const onResize = () => setupAspectsObserver();
  window.addEventListener("resize", onResize, { passive: true });

  onBeforeUnmount(() => {
    aspectsIO?.disconnect();
    window.removeEventListener(
      "title-height-change",
      onTitleHChange as EventListener,
    );
    window.removeEventListener("resize", onResize);
  });
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
  <!-- Intersection observer to compact aspects -->
  <div ref="aspectsSentinel" class="h-3" />
  <div
    class="sticky z-40 top-[var(--title-h,56px)] bg-white/85 dark:bg-slate-900/70 backdrop-blur supports-[backdrop-filter]:bg-white/60"
    :class="
      compactAspects
        ? 'max-w-none w-[100svw] ml-[calc(50%-50svw)] mr-[calc(50%-50svw)] md:px-80 sm:px-20 border-b border-parchment-edge/70 dark:border-slate-700'
        : 'mb-6'
    "
  >
    <SectionCard :compact="compactAspects">
      <template #header>
        <h2 v-if="!compactAspects" class="font-display text-xl">Aspects</h2>
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
          :compact="compactAspects"
        />
        <AspectIndicator
          aspect="shadow"
          :value="empireStore.shadowValue"
          srLabel="Shadow"
          :compact="compactAspects"
        />
        <AspectIndicator
          aspect="chaos"
          :value="empireStore.chaosValue"
          srLabel="Chaos"
          :compact="compactAspects"
        />
        <AspectIndicator
          aspect="materium"
          :value="empireStore.materiumValue"
          srLabel="Materium"
          :compact="compactAspects"
        />
        <AspectIndicator
          aspect="nature"
          :value="empireStore.natureValue"
          srLabel="Nature"
          :compact="compactAspects"
        />
        <AspectIndicator
          aspect="order"
          :value="empireStore.orderValue"
          srLabel="Order"
          :compact="compactAspects"
        />
      </div>
    </SectionCard>
  </div>
  <!-- Two-column responsive form layout -->
  <section class="grid grid-cols-1 lg:grid-cols-2 gap-6">
    <!-- Species -->
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
            :value="empireStore.hasSpeciesTrait(t)"
            @update:value="
              empireStore.hasSpeciesTrait(t)
                ? empireStore.removeSpeciesTrait(t)
                : empireStore.addSpeciesTrait(t)
            "
            :disabled="
              empireStore.speciesTraitPoints < t.cost &&
              !empireStore.hasSpeciesTrait(t)
            "
          >
            <template #badge>
              {{ t.cost }}
            </template>
            {{ t.name }}
          </SelectorChip>
        </div>
      </fieldset>
    </SectionCard>
    <!-- Culture -->
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
      <fieldset>
        <legend class="text-sm font-medium text-ink-soft dark:text-slate-300">
          Traits
          <span class="text-xs ms-1"
            >({{ 2 - empireStore.cultureTraitsCount }})</span
          >
        </legend>
        <div
          class="mt-2 flex flex-wrap gap-2"
          role="group"
          aria-label="Species traits"
        >
          <!-- Culture trait chips -->
          <SelectorChip
            v-for="t in cultureTraitsData"
            :key="t.id"
            :value="empireStore.hasCultureTrait(t)"
            @update:value="
              empireStore.hasCultureTrait(t)
                ? empireStore.removeCultureTrait(t)
                : empireStore.addCultureTrait(t)
            "
            :disabled="
              empireStore.cultureTraitsCount >= 2 &&
              !empireStore.hasCultureTrait(t)
            "
            :badge-class="badgeAspect(t.aspect)"
          >
            <template #badge>
              <AspectIcon />
            </template>
            {{ t.name }}
          </SelectorChip>
        </div>
      </fieldset>
    </SectionCard>
    <!-- Ruler -->
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Ruler</h2>
      </template>
      <SelectField
        id="ruler-type"
        label="Ruler Type"
        :options="rulerTypesOptions"
        :modelValue="rulerTypesModel"
        @update:modelValue="rulerTypesModel = $event"
      />
    </SectionCard>
    <!-- Tomes -->
    <SectionCard>
      <template #header>
        <h2 class="font-display text-xl">Tomes</h2>
      </template>
      <TomeChip
        v-for="t in tomesData"
        :key="t.id"
        :tome="t"
        :value="empireStore.hasTome(t)"
        @update:value="
          empireStore.hasTome(t)
            ? empireStore.removeTome(t)
            : empireStore.addTome(t)
        "
        :disabled="!empireStore.isTomeEligible(t)"
      />
    </SectionCard>
  </section>
</template>
