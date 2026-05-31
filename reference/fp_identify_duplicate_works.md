# Identify duplicate works based on title similarity

Groups potentially duplicate bibliographic records by computing pairwise
string distances between work titles and clustering similar items.

## Usage

``` r
fp_identify_duplicate_works(
  data = NULL,
  string_dist = "lv",
  hclust_method = "single",
  threshold = 0.2
)
```

## Arguments

- data:

  a `data.frame` containing at least a `title` column.

- string_dist:

  a `character` string specifying the distance metric used by
  [`stringdist::stringdistmatrix()`](https://rdrr.io/pkg/stringdist/man/stringdist.html).
  Defaults to `"lv"` (Levenshtein distance).

- hclust_method:

  a `character` string specifying the hierarchical clustering method
  used by [`stats::hclust()`](https://rdrr.io/r/stats/hclust.html).
  Defaults to `"single"`.

- threshold:

  a `numeric` value controlling cluster separation. Lower values produce
  more fine-grained clusters (stricter matching), while higher values
  merge more records into the same group.

## Value

The input `data.frame` with an additional column:

- ref_id:

  Integer cluster identifier grouping similar titles.

## Details

Title similarity is computed after basic text normalization
(lowercasing, punctuation removal, whitespace trimming). Distances are
calculated using
[`stringdist::stringdistmatrix()`](https://rdrr.io/pkg/stringdist/man/stringdist.html)
and normalized by title length before hierarchical clustering.

This function does not remove duplicates but assigns a cluster
identifier that can be used for downstream deduplication or grouping.

## Examples

``` r
if (FALSE) { # \dontrun{
df <- data.frame(
  title = c(
    "Deep Learning for NLP",
    "Deep learning for natural language processing",
    "Quantum Computing Basics"
  )
)

fp_identify_duplicate_works(df)
} # }
```
