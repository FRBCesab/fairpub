# Retrieve the DOI of an article from OpenAlex

This function queries the OpenAlex bibliographic database
(<https://openalex.org>) to retrieve the DOI of an article based on its
title.

## Usage

``` r
fp_retrieve_article_doi(title, n = 5)
```

## Arguments

- title:

  a `character` of length 1. The title of the article.

- n:

  an `integer` of length 1. The number of results to return (between 1
  and 200). Default is `5`.

## Value

A `data.frame` with the following columns:

- `display_name`, the publication titles matching the query

- `publication_year`, the year of publication

- `source_display_name`, the name of the journal

- `doi`, the DOI of the publications

## Examples

``` r
if (FALSE) { # \dontrun{
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

# Search for an full title ----
fp_retrieve_article_doi(
  "Citation self-awareness for a fairer academic publishing landscape"
)
#>                                       display_name publication_year
#> 1 Citation self-awareness for a fairer academic...             2026
#>   source_display_name                    doi
#> 1          BioScience 10.1093/biosci/biag028

# Search for a partial title ----
fp_retrieve_article_doi(
  "Citation fairer academic landscape"
)
#>                                       display_name publication_year
#> 1     Strategic citations for a fairer academic...             2025
#> 2 Citation self-awareness for a fairer academic...             2026
#>                       source_display_name                       doi
#> 1 bioRxiv (Cold Spring Harbor Laboratory) 10.1101/2025.08.06.668908
#> 2                              BioScience    10.1093/biosci/biag028
} # }
```
