import { defineStore } from "pinia";

export interface EmpireState {
  name: string;
  speciesForm: number | null;
}

export const useEmpireStore = defineStore("empire", {
  state: (): EmpireState => ({
    name: "",
    speciesForm: 1,
  }),

  getters: {},

  actions: {},

  // <-- Persistence config
  persist: {
    key: "com.aow4-builder-empire",
    paths: ["empire"], // only these fields are saved
    storage: sessionStorage, // or localStorage / cookies
  },
});
