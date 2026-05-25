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
