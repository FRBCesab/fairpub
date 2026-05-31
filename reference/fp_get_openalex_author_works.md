# Get and filter an author's works from OpenAlex

Queries the OpenAlex bibliographic database (<https://openalex.org>) to
retrieve works associated with an OpenAlex author identifier. Optionally
filters publication types and incomplete records.

## Usage

``` r
fp_get_openalex_author_works(
  author_id = NULL,
  select = c("article", "review", "letter"),
  drop_na = TRUE
)
```

## Arguments

- author_id:

  a `character` of length 1. OpenAlex author ID. This identifier can be
  retrieved with
  [`fp_get_openalex_author_id()`](https://frbcesab.github.io/fairpub/reference/fp_get_openalex_author_id.md).

- select:

  a `character` vector of work types to retain. Use
  [`fp_list_openalex_work_types()`](https://frbcesab.github.io/fairpub/reference/fp_list_openalex_work_types.md)
  to list valid work types. Defaults to
  `c("article", "review", "letter")`. Set to `NULL` to keep all work
  types.

- drop_na:

  a `logical`. If `TRUE` (default), works with missing DOI or missing
  source information are removed.

## Value

A data frame containing one row per work with the following columns:

- id:

  OpenAlex work identifier

- authors:

  Work (first) author

- title:

  Work title

- publication_year:

  Year of publication

- source_display_name:

  Journal or source name

- source_id:

  OpenAlex source identifier

- doi:

  Digital Object Identifier

- cited_by_count:

  Citation count in OpenAlex

- type:

  OpenAlex work type

## Details

This function is a wrapper around the OpenAlex API using the `openalexR`
package. Results are automatically standardized and cleaned for
downstream bibliometric analyses.

Some repositories and preprint servers (e.g. Zenodo, HAL, bioRxiv,
figshare) may be excluded depending on the selected work types.

## Examples

``` r
if (FALSE) { # \dontrun{
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

fp_get_openalex_author_works("A5004806463")
#>          id                    authors                               title
#> 1 W7143431770  Brunno F. Oliveira et al.     Species range shifts often...
#> 2 W7153879999         Miriam Beck et al.    Citation self-awareness for...
#> 3 W4406766122 Érica Rievrs Borges et al.         Road‐river intersectio...
#> 4 W4415048605   Jonathan Bonfanti et al. Geographic, taxonomic and metr...
#> 5 W4411408576      Matthew McLean et al.       Conserving the beauty of...
#> 6 W4415113473     Nicolas Casajus et al.           forcis: An R package...
#>   publication_year                             source_display_name
#> 1             2026 Proceedings of the National Academy of Sciences
#> 2             2026                                      BioScience
#> 3             2025                      Applied Vegetation Science
#> 4             2025                                 Ecology Letters
#> 5             2025 Proceedings of the National Academy of Sciences
#> 6             2025             The Journal of Open Source Software
#>     source_id                     doi cited_by_count    type
#> 1  S125754415 10.1073/pnas.2515903123              1 article
#> 2  S121830084  10.1093/biosci/biag028              0 article
#> 3  S179963793      10.1111/avsc.70011              0 article
#> 4   S80967739       10.1111/ele.70220              1  review
#> 5  S125754415 10.1073/pnas.2415931122              1 article
#> 6 S4210214273     10.21105/joss.09217              0 article
} # }
```
