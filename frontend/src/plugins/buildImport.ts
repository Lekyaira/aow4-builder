import type { Router } from "vue-router";
import { useEmpireStore } from "@/stores/empire";

export function installBuildImport(router: Router) {
  console.log("Running installBuildImport...");
  router.beforeEach((to, from, next) => {
    const maybeBuild = to.query.build;
    console.log("maybeBuild:", maybeBuild);
    if (typeof maybeBuild === "string" && maybeBuild.length > 0) {
      const store = useEmpireStore();
      const ok = store.applyFromUrl(); // this also cleans the URL
      console.log("Applied to store.");
      // Ensure we continue to intended route but without the query
      if (ok) {
        next({ ...to, query: { ...to.query, build: undefined } });
        return;
      }
    }
    next();
  });
}
