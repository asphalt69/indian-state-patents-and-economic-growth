* 03_reverse_direction.do
* Reverse-direction association: economic growth and subsequent patent activity

clear all
set more off
version 17.0

* Load the prepared dataset from your local project folder.
* Update the path once confirmed.
* use "state_panel.dta", clear

* Required package:
* ssc install reghdfe

* Model 1: Prior GSDP per-capita growth and current patent activity
* reghdfe ln_patents_comp L.d_ln_gsdp_pc, absorb(state_id year) vce(cluster state_id)

* Model 2: Prior nighttime-light growth and current patent activity
* reghdfe ln_patents_comp L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)

* Model 3: Both predictors jointly
* reghdfe ln_patents_comp L.d_ln_gsdp_pc L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)

display "Reverse-direction analysis template loaded."
