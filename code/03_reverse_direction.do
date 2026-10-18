* 03_reverse_direction.do
* Reverse-direction associations: economic growth and patent activity

clear all
set more off
version 17.0

* 1. Configure project paths
global project "C:\Users\Sashank Mohan\Desktop"
global input "$project\state_panel.dta"
global output "$project\reverse_direction_results.tex"

* 2. Load prepared data
use "$input", clear
xtset state_id year

* 3. Install required package if needed
capture which reghdfe
if _rc ssc install reghdfe

* 4. Model 1: Prior GSDP growth
reghdfe ln_patents_comp L.d_ln_gsdp_pc, absorb(state_id year) vce(cluster state_id)
estimates store reverse_gsdp

* 5. Model 2: Prior nighttime-light growth
reghdfe ln_patents_comp L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)
estimates store reverse_ntl

* 6. Model 3: Joint specification
reghdfe ln_patents_comp L.d_ln_gsdp_pc L.d_ln_ntl, absorb(state_id year) vce(cluster state_id)
estimates store reverse_joint

* 7. Export results
capture which esttab
if _rc ssc install estout

esttab reverse_gsdp reverse_ntl reverse_joint using "$output", replace se star(* 0.10 ** 0.05 *** 0.01) stats(N r2 r2_a, labels("Observations" "R-squared" "Adjusted R-squared")) mtitles("Prior GSDP Growth" "Prior NTL Growth" "Joint Model") title("Economic Growth and Subsequent Patent Activity") addnotes("State fixed effects: Yes" "Year fixed effects: Yes" "Standard errors clustered by state.")

display "Reverse-direction regressions complete."
