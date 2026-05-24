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
#'   "HTTPS://DOI.ORG/10.1098/RSOS.160384"
#' )
#'
#' fp_clean_doi(dois)

fp_clean_doi <- function(doi) {
  if (missing(doi)) {
    stop("Argument 'doi' is required")
  }

  if (is.null(doi)) {
    stop("Argument 'doi' is required")
  }

  if (!is.character(doi)) {
    stop("Argument 'doi' must be character")
  }

  doi <- gsub("\\s", "", doi)
  doi <- tolower(doi)
  doi <- gsub("http(s)?://(dx.)?doi.org/", "", doi)
  doi <- gsub("doi:", "", doi)

  doi
}
