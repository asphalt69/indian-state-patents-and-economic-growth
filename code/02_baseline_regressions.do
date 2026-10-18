* 02_baseline_regressions.do
* Baseline regressions: patents and economic growth

clear all
set more off
version 17.0

* Load prepared data
use "C:\Users\Sashank Mohan\Desktop\state_panel.dta", clear

* Install reghdfe if needed
capture which reghdfe
if _rc ssc install reghdfe

* Declare panel
xtset state_id year

* Construct common estimation sample
gen byte common_sample = !missing(d_ln_ntl, d_ln_gsdp_pc, d_ln_electricity_pc, L.ln_patents_comp, state_id, year)

* Model 1: Nighttime-light growth
reghdfe d_ln_ntl L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m1

* Model 2: Real GSDP per-capita growth
reghdfe d_ln_gsdp_pc L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m2

* Model 3: Electricity per-capita growth
reghdfe d_ln_electricity_pc L.ln_patents_comp if common_sample == 1, absorb(state_id year) vce(cluster state_id)
estimates store m3

* Export regression table
capture which esttab
if _rc ssc install estout

esttab m1 m2 m3 using "patent_regressions.tex", replace se star(* 0.10 ** 0.05 *** 0.01) stats(N r2 r2_a, labels("Observations" "R-squared" "Adjusted R-squared")) mtitles("
