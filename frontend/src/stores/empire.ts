import { defineStore } from "pinia";
import type {
  Aspect,
  Culture,
  SpeciesForm,
  SpeciesTrait,
} from "@/api/types.gen";
import { cultures, speciesForms } from "@/api/sdk.gen";

export interface EmpireState {
  name: string;
  speciesForm: SpeciesForm | null;
  speciesTraits: SpeciesTrait[];
  culture: Culture | null;
  _initialized: boolean;
}

export const useEmpireStore = defineStore("empire", {
  state: (): EmpireState => ({
    name: "",
    speciesForm: null,
    speciesTraits: [],
    culture: null,
    _initialized: false,
  }),

  getters: {
    astralValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "astral").length;
      return val;
    },
    shadowValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "shadow").length;
      return val;
    },
    chaosValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "chaos").length;
      return val;
    },
    materiumValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "materium").length;
      return val;
    },
    natureValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "nature").length;
      return val;
    },
    orderValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "order").length;
      return val;
    },
    speciesTraitPoints: (state) => {
      let val = 5;
      for (const trait of state.speciesTraits) {
        val -= trait.cost;
      }
      return val;
    },
  },

  actions: {
    async init() {
      if (this._initialized) return;

      try {
        const [speciesFormsData, culturesData] = await Promise.all([
          !this.speciesForm ? speciesForms() : Promise.resolve(null),
          !this.culture ? cultures() : Promise.resolve(null),
        ]);

        if (!this.speciesForm && speciesFormsData?.data?.length)
          this.speciesForm = speciesFormsData.data[0] ?? null;
        if (!this.culture && culturesData?.data?.length)
          this.culture = culturesData.data[0] ?? null;

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
      const index = this.speciesTraits.indexOf(trait);
      if (index === -1) return;
      this.speciesTraits.splice(index, 1);
    },
  },

  // <-- Persistence config
  persist: {
    key: "com.aow4-builder-empire",
    paths: ["name", "speciesForm", "culture"], // only these fields are saved
    storage: sessionStorage, // or localStorage / cookies
  },
});
