# Get the fairness status of a journal

By querying the OpenAlex bibliographic database (<https://openalex.org>)
and the DAFNEE database (<https://dafnee.isem-evolution.fr/>), this
function returns the business model and the academic friendly status of
a journal.

## Usage

``` r
fp_get_journal_fairness(journal = NULL)
```

## Arguments

- journal:

  a `character` of length 1. The name of the journal. Do not use journal
  abbreviation.

## Value

A `data.frame` with two columns: `journal`, the journal name, and
`fairness`, the fairness status with the following possible values:

- Non-profit and academic friendly

- For-profit and academic friendly

- For-profit and non academic friendly

- Record not found in OpenAlex

- Record not found in DAFNEE database

## Examples

``` r
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

if (FALSE) { # \dontrun{
# Fairness status ----
fp_get_journal_fairness("Science")
#>   journal                           fairness
#> 1 Science   Non-profit and academic friendly

# Fuzzy search ----
fp_get_journal_fairness("Science of Nature")
#> No exact match found!
#> The fuzzy search returns these three best candidates:
#>   'The Science of Nature'
#>   'Science Advances'
#>   'People and Nature'

fp_get_journal_fairness("The Science of Nature")
#>                 journal                               fairness
#> 1 The Science of Nature   For-profit and non-academic friendly
} # }
```
