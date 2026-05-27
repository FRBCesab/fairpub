# Get OpenAlex author ID

Queries the OpenAlex bibliographic database (<https://openalex.org>) to
retrieve an author's identifier.

## Usage

``` r
fp_get_openalex_author_id(author, n = 10)
```

## Arguments

- author:

  a `character` vector of length 1. Name of the author.

- n:

  an `integer` of length 1. Number of results to return (between 1 and
  200, default is `10`).

## Value

A data frame with the following columns:

- id:

  OpenAlex author ID

- display_name:

  Author name in OpenAlex

- orcid:

  ORCID identifier

- works_count:

  Number of publications

## Examples

``` r
if (FALSE) { # \dontrun{
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

fp_get_openalex_author_id("Nicolas Casajus")
#>            id    display_name               orcid works_count
#> 1 A5004806463 Nicolas Casajus 0000-0002-5537-5294         102

fp_get_openalex_author_id("Nicolas Mouquet")
#>            id    display_name               orcid works_count
#> 1 A5001034207 Nicolas Mouquet 0000-0003-1840-6984         210
} # }
```
