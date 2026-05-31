#' Get OpenAlex author ID
#'
#' @description
#' Queries the OpenAlex bibliographic database (<https://openalex.org>) to
#' retrieve an author's identifier.
#'
#' @param author a `character` vector of length 1. Name of the author.
#'
#' @param n an `integer` of length 1. Number of results to return (between
#'   1 and 200, default is `10`).
#'
#' @return A data frame with the following columns:
#'   \describe{
#'     \item{id}{OpenAlex author ID}
#'     \item{display_name}{Author name in OpenAlex}
#'     \item{orcid}{ORCID identifier}
#'     \item{works_count}{Number of publications}
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Be polite and send your email to OpenAlex API ----
#' options(openalexR.mailto = 'anonymous@mail.com')
#'
#' fp_get_openalex_author_id("Nicolas Casajus")
#' #>            id    display_name               orcid works_count
#' #> 1 A5004806463 Nicolas Casajus 0000-0002-5537-5294         102
#'
#' fp_get_openalex_author_id("Nicolas Mouquet")
#' #>            id    display_name               orcid works_count
#' #> 1 A5001034207 Nicolas Mouquet 0000-0003-1840-6984         210
#' }

fp_get_openalex_author_id <- function(author = NULL, n = 10) {
  assert_string(author, "author")
  assert_positive_integer(n, "n")
  assert_between(n, 1, 200, "n")

  fp_check_mailto()

  fp_oa_fetch_authors(author, n) |>
    fp_oa_parse_authors()
}


#' @noRd
fp_oa_fetch_authors <- function(author, n) {
  meta <- tryCatch(
    suppressMessages(
      openalexR::oa_fetch(
        entity = "authors",
        search = author,
        per_page = n,
        paging = "page",
        pages = 1,
        options = list(
          sort = "relevance_score:desc",
          select = c(
            "display_name",
            "id",
            "orcid",
            "works_count"
          )
        )
      )
    ),
    error = function(e) {
      stop(
        sprintf("OpenAlex request failed: %s", e$message),
        call. = FALSE
      )
    }
  )

  as.data.frame(meta)
}


#' @noRd
fp_oa_parse_authors <- function(x) {
  cols <- c("id", "display_name", "orcid", "works_count")

  if (nrow(x) > 0) {
    x <- x[, cols, drop = FALSE]

    x$id <- fp_clean_oa_id(x$id)
    x$orcid <- fp_clean_orcid(x$orcid)
  } else {
    x <- data.frame(
      id = character(),
      display_name = character(),
      orcid = character(),
      works_count = integer()
    )
  }

  x
}
