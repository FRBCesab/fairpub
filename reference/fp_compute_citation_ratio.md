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
doi_list
#>  [1] "10.1098/rsos.160384"               NA                                 
#>  [3] "10.1126/science.1212540"           "10.9745/ghsp-d-21-00145"          
#>  [5] "10.1126/science.adk9900"           "10.1016/j.ecolecon.2021.107082"   
#>  [7] "10.1177/014107680609900316"        "10.1093/reseval/rvad012"          
#>  [9] "10.1111/ele.14395"                 "10.3998/ptpbio.3363"              
#> [11] "10.4000/proceedings.elpub.2018.30" "10.1093/scipol/scs093"            
#> [13] NA                                  "10.1002/leap.1102"                
#> [15] "10.1087/0953151053584975"          NA                                 
#> [17] "10.1177/0263395719858571"          "10.1017/s1062798709000532"        
#> [19] "10.1371/journal.pone.0127502"      "10.1162/qss_c_00305"              
#> [21] "10.1007/978-3-030-02511-3_1"       NA                                 
#> [23] "10.1371/journal.pbio.1002264"      "10.3389/frma.2016.00007"          
#> [25] "10.48550/arxiv.2407.16551"         NA                                 
#> [27] "10.1080/08109028.2014.891710"      "10.1007/s11192-022-04586-1"       
#> [29] "10.1098/rspb.2019.2047"            "10.5281/zenodo.4558704"           
#> [31] "10.1162/qss_a_00272"               "10.3917/inno.063.0095"            
#> [33] "10.1371/journal.pone.0243664"      "10.1257/jep.15.4.183"             
#> [35] "10.1073/pnas.0305628101"           "10.1016/j.amjmed.2019.07.028"     
#> [37] "10.32614/rj-2023-089"              "10.5534/wjmh.230001"              

# Compute citation ratios ----
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
#> 
```
