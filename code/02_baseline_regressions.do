* 02_baseline_regressions.do
* Baseline fixed-effects regressions

clear all
set more off
version 17.0

* Load the prepared dataset from your local project folder.
* Update the path once the data preparation script is complete.
* use "state_panel.dta", clear

* Required package:
* ssc install reghdfe

* Model 1: Nighttime-light growth
* reghdfe d_ln_ntl L.ln_patents_comp, absorb(state_id year) vce(cluster state_id)

* Model 2: Real GSDP per-capita growth
* reghdfe d_ln_gsdp_pc L.ln_patents_comp, absorb(state_id year) vce(cluster state_id)

* Model 3: Electricity per-capita growth
* reghdfe d_ln_electricity_pc L.ln_patents_comp, absorb(state_id year) vce(cluster state_id)

display "Baseline regression script template loaded."
