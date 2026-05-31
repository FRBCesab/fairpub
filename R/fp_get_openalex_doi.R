#' Get OpenAlex publication DOI
#'
#' @description
#' Queries the OpenAlex bibliographic database (<https://openalex.org>) to
#' retrieve metadata about publications matching a given title, including
#' their DOI.
#'
#' @param title a `character` vector of length 1. The title of the publication.
#'
#' @inheritParams fp_get_openalex_author_id
#'
#' @return A data frame with the following columns:
#' \describe{
#'   \item{display_name}{Title of the publication}
#'   \item{publication_year}{Year of publication}
#'   \item{source_display_name}{Journal or source name}
#'   \item{doi}{Digital Object Identifier (DOI)}
#' }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Be polite and send your email to OpenAlex API ----
#' options(openalexR.mailto = 'anonymous@mail.com')
#'
#' # Search for an full title ----
#' fp_get_openalex_doi(
#'   "Citation self-awareness for a fairer academic publishing landscape"
#' )
#' #>                                       display_name publication_year
#' #> 1 Citation self-awareness for a fairer academic...             2026
#' #>   source_display_name                    doi
#' #> 1          BioScience 10.1093/biosci/biag028
#'
#' # Search for a partial title ----
#' fp_get_openalex_doi("Citation fairer academic landscape")
#' #>                                       display_name publication_year
#' #> 1     Strategic citations for a fairer academic...             2025
#' #> 2 Citation self-awareness for a fairer academic...             2026
#' #>                       source_display_name                       doi
#' #> 1 bioRxiv (Cold Spring Harbor Laboratory) 10.1101/2025.08.06.668908
#' #> 2                              BioScience    10.1093/biosci/biag028
#' }

fp_get_openalex_doi <- function(title = NULL, n = 10) {
  assert_string(title, "title")
  assert_positive_integer(n, "n")
  assert_between(n, 1, 200, "n")

  fp_check_mailto()

  fp_oa_fetch_dois(title, n) |>
    fp_oa_parse_dois()
}
