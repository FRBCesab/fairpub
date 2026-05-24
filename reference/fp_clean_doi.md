# Clean a DOI vector

This helper cleans DOIs (Digital Object Identifier) by removing prefix
(`doi:`, `https://doi.org/` and `http://dx.doi.org/`) and using lower
case.

## Usage

``` r
fp_clean_doi(doi)
```

## Arguments

- doi:

  a `character` vector with Digital Object Identifiers (DOI).

## Value

A `character` of DOI without prefix and in lower case.

## Examples

``` r
dois <- c(
  "10.1098/rsos.160384",
  "10.1098/RSOS.160384",
  "doi: 10.1098/rsos.160384",
  "http://dx.doi.org/10.1098/rsos.160384",
  "https://doi.org/10.1098/rsos.160384",
  "HTTPS://DOI.ORG/10.1098/RSOS.160384",
  NA
)

fp_clean_doi(dois)
#> [1] "10.1098/rsos.160384" "10.1098/rsos.160384" "10.1098/rsos.160384"
#> [4] "10.1098/rsos.160384" "10.1098/rsos.160384" "10.1098/rsos.160384"
#> [7] NA                   
```
