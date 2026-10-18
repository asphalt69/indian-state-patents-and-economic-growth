# Code

This directory contains the Stata scripts used to prepare the state-level panel dataset and estimate the regression models.

## Scripts

1. `01_prepare_data.do` — Imports the source Excel file, constructs state and year identifiers, transforms variables, calculates log changes, and saves the prepared panel.
2. `02_baseline_regressions.do` — Estimates the baseline regressions relating lagged patent activity to nighttime-light growth, real GSDP per-capita growth, and electricity consumption growth.
3. `03_reverse_direction.do` — Examines whether previous economic growth is associated with subsequent patent activity.

## Requirements

- Stata 17 or later.
- The `reghdfe` package.
- The `estout` package for exporting regression tables.

The scripts install the required Stata packages if they are not already available.

## Running the scripts

Run the scripts from the project root directory, in this order:

1. `code/01_prepare_data.do`
2. `code/02_baseline_regressions.do`
3. `code/03_reverse_direction.do`

Place the source Excel file, `Test.xlsx`, in the project root before running the preparation script. The prepared dataset, `state_panel.dta`, is then saved there and used by the regression scripts.

The regression tables are exported to the `results/` directory. Ensure this directory exists before running the regression scripts.

**Note:** The raw dataset is not included in this repository. Users must obtain the source data separately and place it in the expected location.
