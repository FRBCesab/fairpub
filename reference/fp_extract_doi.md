# Extract DOI from a BibTeX file or a string

This function detects and extracts DOI from bibliographic records. User
can provides either a `character` vector (argument `x`) or the path to a
BibTex file (argument `file`).

## Usage

``` r
fp_extract_doi(x = NULL, file = NULL)
```

## Arguments

- x:

  a `character` vector. A string containing bibliographic records.

- file:

  a `character` of length 1. The path to the BibTeX file to open.

## Value

A `character` vector with extracted DOI. Some values can be `NA` in case
of books, chapters, etc. or if references are malformed in the BibTeX.

## Examples

``` r
# Argument 'x' (one DOI per element) ----
string <- c(
  "Beck M (2026) Citation self-awareness... 10.1093/biosci/biag028.",
  "Galtier N (2026) Time to publish... DOI: 10.32942/X24933",
  "Doe J (9999) Title... http://dx.doi.org/10.1162/qss(c)_00305",
  "Receveur A (2024) David vs Goliath... https://doi.org/10.1111/ele.14395",
  "Smith J (9999) This is a fake article."
)

## Extract DOI from a vector ----
fp_extract_doi(x = string)
#> [1] "10.1093/biosci/biag028" "10.32942/x24933"        "10.1162/qss(c)_00305"  
#> [4] "10.1111/ele.14395"     

# Argument 'x' (many DOI per element) ----
string <- paste(string, collapse = "\n")
cat(string)
#> Beck M (2026) Citation self-awareness... 10.1093/biosci/biag028.
#> Galtier N (2026) Time to publish... DOI: 10.32942/X24933
#> Doe J (9999) Title... http://dx.doi.org/10.1162/qss(c)_00305
#> Receveur A (2024) David vs Goliath... https://doi.org/10.1111/ele.14395
#> Smith J (9999) This is a fake article.

## Extract DOI from a vector ----
fp_extract_doi(x = string)
#> [1] "10.1093/biosci/biag028" "10.32942/x24933"        "10.1162/qss(c)_00305"  
#> [4] "10.1111/ele.14395"     

# Argument 'file' ----

## Path to the BibTeX provided by <fairpub> ----
filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

## Extract DOI from BibTeX ----
fp_extract_doi(file = filename)
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
```
