#' Clean a DOI vector
#'
#' @description
#' This helper cleans DOIs (Digital Object Identifier) by removing prefix
#' (`doi:`, `https://doi.org/` and `http://dx.doi.org/`) and using lower case.
#'
#' @param doi a `character` vector with Digital Object Identifiers (DOI).
#'
#' @return A `character` of DOI without prefix and in lower case.
#'
#' @export
#'
#' @examples
#' dois <- c(
#'   "10.1098/rsos.160384",
#'   "10.1098/RSOS.160384",
#'   "doi: 10.1098/rsos.160384",
#'   "http://dx.doi.org/10.1098/rsos.160384",
#'   "https://doi.org/10.1098/rsos.160384",
#'   "HTTPS://DOI.ORG/10.1098/RSOS.160384",
#'   NA
#' )
#'
#' fp_clean_doi(dois)

fp_clean_doi <- function(doi) {
  check_arg_doi(doi)

  doi |>
    tolower() |>
    gsub("\\s", "", x = _) |>
    gsub(.DOI_PREFIX, "", x = _)
}
