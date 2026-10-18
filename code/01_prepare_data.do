* 01_prepare_data.do
* Indian State Patents and Economic Growth
* Data preparation and panel construction

clear all
set more off
version 17.0

* 1. Import source data
import excel "C:\Users\Sashank Mohan\Desktop\Test.xlsx", sheet("Sheet1") firstrow clear

* 2. Construct state identifier
encode viirs_state_matched, gen(state_id)

* 3. Construct fiscal year
gen year = real(substr(gsdp_fy_label,1,4))
replace year = real(substr(patent_fiscal_year_label,1,4)) if missing(gsdp_fy_label) & !missing(patent_fiscal_year_label)
replace year = viirs_year_matched - 1 if missing(year) & !missing(viirs_year_matched)

* 4. Declare state-year panel
isid state_id year
xtset state_id year

* 5. Construct transformed variables
gen ln_patents_comp = ln(1 + patent_applications_total) if patent_applications_total >= 0
gen ln_gsdp_pc = ln(real_gsdp_per_capita_rupees_2011) if real_gsdp_per_capita_rupees_2011 > 0
gen ln_electricity_pc = ln(per_capita_energy_kwh_per_1000_p) if per_capita_energy_kwh_per_1000_p > 0

* 6. Construct log changes
gen d_ln_ntl = D.ln_NTL_mean
gen d_ln_gsdp_pc = D.ln_gsdp_pc
gen d_ln_electricity_pc = D.ln_electricity_pc

* 7. Save prepared dataset
save "C:\Users\Sashank Mohan\Desktop\state_panel.dta", replace

display "Data preparation complete."
