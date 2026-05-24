#' Retrieve the DOI of an article from OpenAlex
#'
#' @description
#' This function queries the OpenAlex bibliographic database
#' (<https://openalex.org>) to retrieve the DOI of an article based on its
#' title.
#'
#' @param title a `character` of length 1. The title of the article.
#'
#' @param n an `integer` of length 1. The number of results to return (between
#'   1 and 200). Default is `5`.
#'
#' @return A `data.frame` with the following columns:
#'   - `display_name`, the publication titles matching the query
#'   - `publication_year`, the year of publication
#'   - `source_display_name`, the name of the journal
#'   - `doi`, the DOI of the publications
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Be polite and send your email to OpenAlex API ----
#' options(openalexR.mailto = 'anonymous@mail.com')
#'
#' # Search for an full title ----
#' fp_retrieve_article_doi(
#'   "Citation self-awareness for a fairer academic publishing landscape"
#' )
#' #>                                       display_name publication_year
#' #> 1 Citation self-awareness for a fairer academic...             2026
#' #>   source_display_name                    doi
#' #> 1          BioScience 10.1093/biosci/biag028
#'
#' # Search for a partial title ----
#' fp_retrieve_article_doi(
#'   "Citation fairer academic landscape"
#' )
#' #>                                       display_name publication_year
#' #> 1     Strategic citations for a fairer academic...             2025
#' #> 2 Citation self-awareness for a fairer academic...             2026
#' #>                       source_display_name                       doi
#' #> 1 bioRxiv (Cold Spring Harbor Laboratory) 10.1101/2025.08.06.668908
#' #> 2                              BioScience    10.1093/biosci/biag028
#' }

fp_retrieve_article_doi <- function(title, n = 5) {
  fp_check_mailto()

  check_arg_string(title)
  check_arg_n(n)

  meta <- tryCatch(
    suppressMessages(
      openalexR::oa_fetch(
        entity = "works",
        title.search = title,
        per_page = n,
        paging = "page",
        pages = 1,
        options = list(
          sort = "relevance_score:desc",
          select = c(
            "doi",
            "display_name",
            "publication_year",
            "primary_location"
          )
        )
      )
    ),
    error = function(e) {
      stop(
        "Failed to retrieve data from OpenAlex",
        call. = FALSE
      )
    }
  )

  meta <- as.data.frame(meta)

  if (nrow(meta) > 0) {
    meta <- meta[, c(
      "display_name",
      "publication_year",
      "source_display_name",
      "doi"
    )]

    meta$doi <- fp_clean_doi(meta$doi)
    meta$display_name <- fp_shorten_string(meta$display_name)
  } else {
    meta <- data.frame(
      display_name = character(),
      publication_year = integer(),
      source_display_name = character(),
      doi = character()
    )
  }

  meta
}
