# Non profit & academic friendly ratio of citations

Scientific journals operate over a broad spectrum of publishing
strategies, from strictly for-profit, to non-profit, and in-between
business models (e.g. for-profit but academic friendly journals).

From a list of references, this function computes three citation ratios:
the proportion of non-profit citations, the proportion of for-profit and
academic friendly citations, and the proportion of for-profit and
non-academic friendly citations (Beck *et al.* 2026).

It uses the OpenAlex bibliographic database (<https://openalex.org>) to
retrieve journal names from article DOI and the DAFNEE database
(<https://dafnee.isem-evolution.fr/>) to get the business model and the
academic friendly status of journals.

## Usage

``` r
fp_compute_citation_ratio(doi)
```

## Arguments

- doi:

  a `character` vector of Digital Object Identifiers (DOI). Can contain
  `NA` (book, book chapter, etc.).

## Value

A `list` of two elements:

- `summary`, a `data.frame` with two columns (`metric` and `value`)
  reporting the following statistics:

  - number of total references (length of `doi` argument)

  - number of references with DOI

  - number of deduplicated references

  - number of references found in the OpenAlex database

  - number of references whose journal is indexed in the DAFNEE database

  - number of non-profit and academic friendly references

  - number of for-profit and academic friendly references

  - number of for-profit and non academic friendly references

- `ratios`, a vector of three ratios:

  - non-profit and academic friendly ratio

  - for-profit and academic friendly ratio

  - for-profit and non academic friendly ratio

## References

Beck M et al. (2026) Citation self-awareness for a fairer academic
publishing landscape. **BioScience**. DOI:
[doi:10.1093/biosci/biag028](https://doi.org/10.1093/biosci/biag028)

## Examples

``` r
# Be polite and send your email to OpenAlex API ----
options(openalexR.mailto = 'anonymous@mail.com')

# Path to the BibTeX provided by <fairpub> ----
filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

# Extract DOI from BibTeX ----
doi_list <- fp_extract_doi(filename)

# Print DOI ----
head(doi_list)
#> [1] "10.1098/rsos.160384"            NA                              
#> [3] "10.1126/science.1212540"        "10.9745/ghsp-d-21-00145"       
#> [5] "10.1126/science.adk9900"        "10.1016/j.ecolecon.2021.107082"

if (FALSE) { # \dontrun{
# Compute citation ratio ----
fp_compute_citation_ratio(doi_list)
#> $summary
#>                                            metric value
#> 1                                Total references    38
#> 2                             References with DOI    33
#> 3                         Deduplicated references    33
#> 4                    References found in OpenAlex    33
#> 5                      References found in DAFNEE    11
#> 6     Non-profit and academic friendly references     9
#> 7     For-profit and academic friendly references     2
#> 8 For-profit and non-academic friendly references     0
#> 
#> $ratios
#>     Non-profit and academic friendly     For-profit and academic friendly 
#>                                 0.82                                 0.18 
#> For-profit and non-academic friendly 
#>                                 0.00 
} # }
```
