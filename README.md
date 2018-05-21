# OOPA notices experiment

This repository stores code used to randomly assign properties in the City of Philadelphia
to receive different notifications regarding the Owner-Occupied Payment Agreeemnt (OOPA) program, 
and to analyze the results of the experiment after notices are sent.

This work is funded by the PHL Participatory Design Lab, and funded by the 
[Knight Cities Challenge grant](https://knightfoundation.org/grants/8000).

Learn more about OOPA
[here](https://beta.phila.gov/services/payments-assistance-taxes/payment-plans/owner-occupied-real-estate-tax-payment-agreement/).

While Philadelphia property tax data is public, OOPA status is not, so the randomization and analysis cannot be fully replicated.

## Data sources

City property data and OOPA data is pulled from city mainframes.
OOPA data (for balancing randomization and measuring outcome) is confidential, and cannot be posted here.

## Directory structure

* `preprocessing` contains scripts to clean raw data into files for randomization and/or analysis.
* `randomization` contains scripts to generate treatment assignments for properties in the city and checks balance. The randomization plan is [here](randomization/README.md).
* `analysis` contains
    * Pre-experiment exploration of data and power calculations, and
    * Scripts to merge outcome data and randomization data, and measure the effects of the experimental treatments.