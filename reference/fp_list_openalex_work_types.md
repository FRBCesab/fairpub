# List valid OpenAlex work types

Returns the set of work types recognized by the OpenAlex database and
used for filtering bibliographic records.

## Usage

``` r
fp_list_openalex_work_types()
```

## Value

a `character` vector of valid OpenAlex work types.

## Details

These work types correspond to the classification system used by
OpenAlex to describe scholarly outputs. They can be used to filter
results in functions such as
[`fp_get_openalex_author_works()`](https://frbcesab.github.io/fairpub/reference/fp_get_openalex_author_works.md).

## Examples

``` r
fp_list_openalex_work_types()
#>  [1] "article"                 "book"                   
#>  [3] "book-chapter"            "dataset"                
#>  [5] "dissertation"            "editorial"              
#>  [7] "erratum"                 "letter"                 
#>  [9] "libguides"               "other"                  
#> [11] "paratext"                "peer-review"            
#> [13] "preprint"                "reference-entry"        
#> [15] "report"                  "retraction"             
#> [17] "review"                  "standard"               
#> [19] "supplementary-materials"
```
