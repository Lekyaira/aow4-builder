import { defineStore } from "pinia";
import type {
  Aspect,
  Culture,
  CultureTrait,
  SpeciesForm,
  SpeciesTrait,
  Ruler,
  Tome,
} from "@/api/types.gen";
import { cultures, speciesForms, rulerTypes } from "@/api/sdk.gen";

export interface EmpireState {
  name: string;
  speciesForm: SpeciesForm | null;
  speciesTraits: SpeciesTrait[];
  culture: Culture | null;
  cultureTraits: CultureTrait[];
  rulerType: Ruler | null;
  tomes: Tome[];
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
    tomes: [],
    _initialized: false,
  }),

  getters: {
    astralValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "astral").length;
      val += state.cultureTraits.filter((a) => a.aspect === "astral").length;
      val += state.rulerType?.aspects.filter((a) => a === "astral").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "astral").length;
      return val;
    },
    shadowValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "shadow").length;
      val += state.cultureTraits.filter((a) => a.aspect === "shadow").length;
      val += state.rulerType?.aspects.filter((a) => a === "shadow").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "shadow").length;
      return val;
    },
    chaosValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "chaos").length;
      val += state.cultureTraits.filter((a) => a.aspect === "chaos").length;
      val += state.rulerType?.aspects.filter((a) => a === "chaos").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "chaos").length;
      return val;
    },
    materiumValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "materium").length;
      val += state.cultureTraits.filter((a) => a.aspect === "materium").length;
      val += state.rulerType?.aspects.filter((a) => a === "materium").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "materium").length;
      return val;
    },
    natureValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "nature").length;
      val += state.cultureTraits.filter((a) => a.aspect === "nature").length;
      val += state.rulerType?.aspects.filter((a) => a === "nature").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "nature").length;
      return val;
    },
    orderValue: (state) => {
      let val = 0;
      val += state.culture?.aspects.filter((a) => a === "order").length;
      val += state.cultureTraits.filter((a) => a.aspect === "order").length;
      val += state.rulerType?.aspects.filter((a) => a === "order").length;
      for (const tome of state.tomes)
        val += tome.aspects.filter((a) => a === "order").length;
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
    highestTomeTier: (state) =>
      state.tomes.length ? Math.max(...state.tomes.map((t) => t.tier)) : 0,

    // Count of tomes at that highest tier
    highestTomeTierCount(): number {
      const max = this.highestTomeTier;
      if (max === 0) return 0;
      return this.tomes.reduce((n, t) => n + (t.tier === max ? 1 : 0), 0);
    },
    tomeCountsByTier(state) {
      return state.tomes.reduce(
        (m, t) => {
          m[t.tier] = (m[t.tier] ?? 0) + 1;
          return m;
        },
        {} as Record<number, number>,
      );
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
    canAffordTome(tome: Tome): boolean {
      let totalAspects = 0;
      let aspectsChecked: Aspect[] = [];
      for (const aspect of tome.aspects) {
        if (!aspectsChecked.some((a) => a === aspect)) {
          aspectsChecked.push(aspect);
          switch (aspect) {
            case "astral": {
              totalAspects += this.astralValue;
              break;
            }
            case "shadow": {
              totalAspects += this.shadowValue;
              break;
            }
            case "chaos": {
              totalAspects += this.chaosValue;
              break;
            }
            case "materium": {
              totalAspects += this.materiumValue;
              break;
            }
            case "nature": {
              totalAspects += this.natureValue;
              break;
            }
            case "order": {
              totalAspects += this.orderValue;
              break;
            }
          }
        }
      }
      let requires = 0;
      switch (tome.tier) {
        case 3: {
          requires = 3;
          break;
        }
        case 4: {
          requires = 6;
          break;
        }
        case 5: {
          requires = 8;
          break;
        }
      }
      if (totalAspects < requires) return false;
      return true;
    },
    addTome(tome: Tome): boolean {
      if (!this.canAffordTome(tome)) return false;
      this.tomes.push(tome);
      return true;
    },
    removeTome(tome: Tome) {
      this.tomes = this.tomes.filter((t) => t.id !== tome.id);
    },
    hasTome(tome: Tome): boolean {
      return this.tomes.some((t) => t.id === tome.id);
    },
    isTomeEligible(t: Tome): boolean {
      const canAfford = this.canAffordTome(t);
      const meetsTier = this.tomes.length >= 2 * (t.tier - 1);
      return canAfford && meetsTier;
    },
  },

  // <-- Persistence config
  persist: {
    key: "com.aow4-builder-empire",
    paths: [
      "name",
      "speciesForm",
      "speciesTraits",
      "culture",
      "cultureTraits",
      "rulerType",
      "tomes",
    ], // only these fields are saved
    storage: sessionStorage, // or localStorage / cookies
  },
});
