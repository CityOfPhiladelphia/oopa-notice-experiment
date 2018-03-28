# Randomization plan

## Data sources

* List of active BRT numbers (one number per property parcel in the city) and address from TIPS export (`data/raw/path-to-file.csv`) cleaned into `parcels.csv`
* Current OOPA status and tier agreement from OOPA annual report dated February 14th, 2018 (`data/raw/OOPA1317 - v2.txt`), cleaned into `data/OOPA_report_clean.csv`

## Universe information

The randomization universe is all properties in the City of Philadelphia, defined by BRT (n = 600,000, approximately - UPDATE)

OOPA data is at the OOPA case level (may include multiple cases per property as agreements end and restart). Case-level variables must be collapsed to the BRT level

## Variable definitions

* `case`: OOPA case number, *not* unique by property (a property could change hands, or an agreement could end and restart with a new case number).
* `brt`: BRT number, **unit of randomization,** unique by property. By policy, residents cannot have OOPAs on multiple properties (since they cannot occupy more than one residence).
* `num_pmts`: Number of payments received by 2017-12-31
* `status`: Case status, either 520 (ongoing), 530 (defaulted), or 560 (completed).
* `agree_start`: Date agreement started
* `default_dt`: Date agreement defaulted (if any)
* `complete_dt`: Date agreement completed (if any)
* `prin_paid`: Amount of principle paid to date, in dollars
* `int_paid`: Amount of interest paid to date, in dollars
* `pen_paid`: Amount of penalty paid to date, in dollars
* `oth_paid`: Other fees paid to date, in dollars
* `tier`: OOPA tier of agreement (1--4 in current data)

Waiting on:

* Full address including zip code

## Randomization

### Treatment assignment

* Control group assigned to receive existing letter (50%)
* Treatment group assigned to receive updated letter (50%)

### Stratificaiton

Treatment assignment will be stratified by:

* Current OOPA status
    * Not in OOPA
    * Currently in OOPA, good standing
    * Currently in OOPA, in material breach
    * Previously in OOPA, completed
    * Previously in OOPA, defaulted
* OOPA tier
    * `Missing` if not in OOPA
    * 1--4 if in OOPA. "Tier 5" agreements do not apply during the time period covered by this data.
* Agreement amount
    * NA if not in OOPA
    * Quantiles if in OOPA (TBD)
* Zip code
    * 60 levels - may need to move to balance check if strata sizes get too small.

### Balance check

Logit regression: `treat ~ oopa_status + tier + agree_amt + zip`

### Data checks

* Are BRTs unique?
* Does the number of BRTs match the number of BRTs in the full file?
* Are there duplicate mailing addresses?
* Are there missing mailing addresses / names?

## Export

* CSV with two columns
    * `brt`: BRT number
    * `treat`: Treatment assignment (Control / New Letter)
