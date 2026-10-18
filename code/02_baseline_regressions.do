* 02_baseline_regressions.do
* Baseline regressions: patents and economic growth

clear all
set more off
version 17.0

* 1. Configure project paths
global project "."
global input "$project\state_panel.dta"
global output "$project\results\patent_regressions.tex"
capture mkdir "$project\results"

* 2. Load prepared data
use "$input", clear
xtset state_id year

* 3. Construct common estimation sample
gen byte common_sample = !missing(d_ln_ntl, d_ln_gsdp_pc, d_ln_electricity_pc, L.ln_patents_comp, state_id, year)

* 4. Model 1: Nighttime-light growth
capture which reghdfe
if _rc ssc install reghdfe
reghdfe d_ln_ntl L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m1

* 5. Model 2: Real GSDP per-capita growth
reghdfe d_ln_gsdp_pc L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m2

* 6. Model 3: Electricity per-capita growth
reghdfe d_ln_electricity_pc L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m3

* 7. Export regression table
capture which esttab
if _rc ssc install estout

esttab m1 m2 m3 using "$output", replace se star(* 0.10 ** 0.05 *** 0.01) stats(N r2 r2_a, labels("Observations" "R-squared" "Adjusted R-squared")) mtitles("NTL Growth" "GSDP per Capita Growth" "Electricity per Capita Growth") title("Lagged Patent Activity and State-Level Growth") addnotes("State fixed effects: Yes" "Year fixed effects: Yes" "Standard errors clustered by state.")

display "Baseline regressions complete."
