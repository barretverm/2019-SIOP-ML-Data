# Data Cleaning Workflow & Data Description

The cleaned data outlined in this repository
(2019_SIOP_ML_Full_Clean.csv) was mapped onto the competition data found
in the raw_data folder (2019_siop_ml_comp_data.csv) by Respondent_ID.
This effectively excludes participants that were removed for failing
attention checks.

## Open-Ended Questionnaires (SJTs)

Open-ended responses were prepended with the first letter of each
personality trait (e.g., "A_open_ended_Q1" reflects trait
agreeableness).

## BFI-2

-   1 = Disagree strongly,
-   2 = Disagree a little,
-   3 = Neutral; no opinion,
-   4 = Agree a little,
-   5 = Agree strongly

The scale scores (e.g., "A_Scale_score") reflect the mean scores of each
trait measured by the BFI-2.

Item-level scores on the BFI-2 are prepended with the first letter of
the respective personality trait they are measuring (e.g., E_1 =
extraversion, item 1).

Attention check items were removed.

Reverse-coded items (appended with "R") were reverse-scored in the
script. If you need the scale data in its original form, you will have
to reverse-score the reverse-scored items.

## \_length

The "\_length" (e.g., Q1_length) variables reflect the text lengths of
each open-ended response.

## gender

-   1 = "Female",
-   2 = "Male"

Missing (NA) = 6 cases

## country

-   1 = "United States"
-   0 = "Other (please specify)"

## country_other

Text responses

-   "Spain", "Japan", "Finland", "Australia", "india"

Missing (NA) total = 6 cases

## race

-   1 = "White",
-   2 = "Black or African-American",
-   3 = "American Indian or Alaskan Native",
-   4 = "Asian",
-   5 = "Native Hawaiian or other Pacific Islander",
-   6 = "From multiple races"

## race_other

Text responses

-   "human", "latina", "hispanic", "latin", "latino", "Hispanic",
    "Hispanic", "Mexican American Native", "Latin American", "Hispanic",
    "Middle Eastern"

Missing (NA) total = 6 cases

## age

-   2 = "18-20",
-   3 = "21-29",
-   4 = "30-39",
-   5 = "40-49",
-   6 = "50-59",
-   7 = "60 or older"

Missing (NA) = 8 cases

## education

-   2 = "Attended high school but did not complete",
-   3 = "Graduated from high school",
-   4 = "Some college",
-   5 = "Associates degree",
-   6 = "Graduated from college (B.A./B.S.)",
-   7 = "Some graduate school",
-   8 = "Completed graduate school"

Missing (NA) = 5 cases

## Dataset

The training, dev, and test partitions were kept the same as the competition dataset. 
