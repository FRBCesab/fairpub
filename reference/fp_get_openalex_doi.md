# Get OpenAlex publication DOI

Queries the OpenAlex bibliographic database (<https://openalex.org>) to
retrieve metadata about publications matching a given title, including
their DOI.

## Usage

``` r
fp_get_openalex_doi(title = NULL, n = 10)
```

## Arguments

- title:

  a `character` vector of length 1. The title of the publication.

- n:

  an `integer` of length 1. Number of results to return (between 1 and
  200, default is `10`).

## Value

A data frame with the following columns:

- display_name:

  Title of the publication

- publication_year:

  Year of publication

- source_display_name:

  Journal or source name

- doi:

  Digital Object Identifier (DOI)

## Examples

``` r
if (FALSE) { # \dontrun{
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

# Search for an full title ----
fp_get_openalex_doi(
  "Citation self-awareness for a fairer academic publishing landscape"
)
#>                                       display_name publication_year
#> 1 Citation self-awareness for a fairer academic...             2026
#>   source_display_name                    doi
#> 1          BioScience 10.1093/biosci/biag028

# Search for a partial title ----
fp_get_openalex_doi("Citation fairer academic landscape")
#>                                       display_name publication_year
#> 1     Strategic citations for a fairer academic...             2025
#> 2 Citation self-awareness for a fairer academic...             2026
#>                       source_display_name                       doi
#> 1 bioRxiv (Cold Spring Harbor Laboratory) 10.1101/2025.08.06.668908
#> 2                              BioScience    10.1093/biosci/biag028
} # }
```
