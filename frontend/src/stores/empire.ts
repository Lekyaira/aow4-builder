import { defineStore } from "pinia";
import type {
  Aspect,
  Culture,
  CultureTrait,
  SpeciesForm,
  SpeciesTrait,
  Ruler,
} from "@/api/types.gen";
import { cultures, speciesForms, rulerTypes } from "@/api/sdk.gen";

export interface EmpireState {
  name: string;
  speciesForm: SpeciesForm | null;
  speciesTraits: SpeciesTrait[];
  culture: Culture | null;
  cultureTraits: CultureTrait[];
  rulerType: Ruler | null;
  _initialized: boolean;
}

export const useEmpireStore = defineStore("empire", {
  state: (): EmpireState => ({
    name: "",
    speciesForm: null,
    speciesTraits: [],
    culture: null,
    cultureTraits: [],
    rulerType: null,
    _initialized: false,
  }),

  getters: {
    astralValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "astral").length;
      val += state.cultureTraits.filter((a) => a.aspect === "astral").length;
      val += state.rulerType?.aspects.filter((a) => a === "astral").length;
      return val;
    },
    shadowValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "shadow").length;
      val += state.cultureTraits.filter((a) => a.aspect === "shadow").length;
      val += state.rulerType?.aspects.filter((a) => a === "shadow").length;
      return val;
    },
    chaosValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "chaos").length;
      val += state.cultureTraits.filter((a) => a.aspect === "chaos").length;
      val += state.rulerType?.aspects.filter((a) => a === "chaos").length;
      return val;
    },
    materiumValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "materium").length;
      val += state.cultureTraits.filter((a) => a.aspect === "materium").length;
      val += state.rulerType?.aspects.filter((a) => a === "materium").length;
      return val;
    },
    natureValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "nature").length;
      val += state.cultureTraits.filter((a) => a.aspect === "nature").length;
      val += state.rulerType?.aspects.filter((a) => a === "nature").length;
      return val;
    },
    orderValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "order").length;
      val += state.cultureTraits.filter((a) => a.aspect === "order").length;
      val += state.rulerType?.aspects.filter((a) => a === "order").length;
      return val;
    },
    speciesTraitPoints: (state) => {
      let val = 5;
      for (const trait of state.speciesTraits) {
        val -= trait.cost;
      }
      return val;
    },
    cultureTraitsCount: (state) => {
      return state.cultureTraits.length;
    },
  },

  actions: {
    async init() {
      if (this._initialized) return;

      try {
        const [speciesFormsData, culturesData, rulerTypesData] =
          await Promise.all([
            !this.speciesForm ? speciesForms() : Promise.resolve(null),
            !this.culture ? cultures() : Promise.resolve(null),
            !this.rulerType ? rulerTypes() : Promise.resolve(null),
          ]);

        if (!this.speciesForm && speciesFormsData?.data?.length)
          this.speciesForm = speciesFormsData.data[0] ?? null;
        if (!this.culture && culturesData?.data?.length)
          this.culture = culturesData.data[0] ?? null;
        if (!this.rulerType && rulerTypesData?.data?.length)
          this.rulerType = rulerTypesData.data[0] ?? null;

        this._initialized = true;
      } catch (err) {
        console.error("Empire initialization failed:", err);
        this._initialized = false;
      }
    },
    addSpeciesTrait(trait: SpeciesTrait): boolean {
      if (this.speciesTraitPoints - trait.cost < 0) return false;
      this.speciesTraits.push(trait);
      return true;
    },
    removeSpeciesTrait(trait: SpeciesTrait) {
      this.speciesTraits = this.speciesTraits.filter((t) => t.id !== trait.id);
    },
    hasSpeciesTrait(trait: SpeciesTrait): boolean {
      return this.speciesTraits.some((t) => t.id === trait.id);
    },
    addCultureTrait(trait: CultureTrait) {
      if (this.cultureTraits.length >= 2) return false;
      this.cultureTraits.push(trait);
      return true;
    },
    removeCultureTrait(trait: CultureTrait) {
      this.cultureTraits = this.cultureTraits.filter((t) => t.id !== trait.id);
    },
    hasCultureTrait(trait: CultureTrait): boolean {
      return this.cultureTraits.some((t) => t.id === trait.id);
    },
  },

  // <-- Persistence config
  persist: {
    key: "com.aow4-builder-empire",
    paths: ["name", "speciesForm", "speciesTraits", "culture", "cultureTraits"], // only these fields are saved
    storage: sessionStorage, // or localStorage / cookies
  },
});
