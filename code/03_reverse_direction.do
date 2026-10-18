  * 03_reverse_direction.do
* Reverse-direction associations: economic growth and patent activity

clear all
set more off
version 17.0

* Load prepared dataset
use "C:\Users\Sashank Mohan\Desktop\state_panel.dta", clear

* Ensure panel is declared
xtset state_id year

* Install reghdfe if needed
capture which reghdfe
if _rc ssc install reghdfe

* Model 1: Prior GSDP per-capita growth and current patent activity
reghdfe ln_patents_comp L.d_ln_gsdp_pc, absorb(state_id year) vce(cluster state_id)
estimates store reverse_gsdp

* Model 2: Prior nighttime-light growth and current patent activity
reghdfe ln_patents_comp L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)
estimates store reverse_ntl

* Model 3: Both predictors jointly
reghdfe ln_patents_comp L.d_ln_gsdp_pc L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)
estimates store reverse_joint

* Export reverse-direction results
capture which esttab
if _rc ssc install estout

esttab reverse_gsdp reverse_ntl reverse_joint using "reverse_direction_results.tex", replace se star(* 0.10 ** 0.05 *** 0.01) stats(N r2 r2_a, labels("Observations" "R-squared" "Adjusted R-squared")) mtitles("Prior GSDP Growth" "Prior NTL Growth" "Joint Model") title("Economic Growth and Subsequent Patent Activity") addnotes("State fixed effects: Yes" "Year fixed effects: Yes" "Standard errors clustered by state.")

display "Reverse-direction regressions complete."
