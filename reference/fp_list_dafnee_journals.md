# List DAFNEE journals

The DAFNEE database (Database of Academia‑Friendly Journals in Ecology
and Evolution, <https://dafnee.isem-evolution.fr/>) provides the
business model and the academic friendly status of several journals in
the field of Ecology and Evolution.

The `fairpub` package provides a selection of 287 DAFNEE journals and
this function returns information about these journals.

## Usage

``` r
fp_list_dafnee_journals()
```

## Value

A `data.frame` with three columns:

- `journal`, the name of the journal

- `business_model`, the business model of the journal (non-profit or
  for-profit)

- `academic_friendly`, the academic friendly status of the journal (yes
  or no)

## Examples

``` r
# List DAFNEE journals in fairpub ----
journals <- fp_list_dafnee_journals()

# Number of journals ----
nrow(journals)
#> [1] 287

# Preview of the outputs ----
head(journals)
#>                                                           journal
#> 1                                                  Acta Amazonica
#> 2                                                 acta ethologica
#> 3                                                 Acta Oecologica
#> 4 Advances in ecological research/Advances in Ecological Research
#> 5                                      African Journal of Ecology
#> 6                     African Journal of Range and Forage Science
#>   business_model academic_friendly
#> 1     Non-profit               Yes
#> 2     For-profit                No
#> 3     For-profit                No
#> 4     For-profit                No
#> 5     For-profit               Yes
#> 6     For-profit               Yes
```
