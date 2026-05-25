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

#' @noRd
fp_oa_fetch_dois <- function(title, n) {
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
        sprintf("OpenAlex request failed: %s", e$message),
        call. = FALSE
      )
    }
  )

  as.data.frame(meta)
}

#' @noRd
fp_oa_parse_dois <- function(x) {
  cols <- c("display_name", "publication_year", "source_display_name", "doi")

  if (nrow(x) > 0) {
    x <- x[, cols, drop = FALSE]

    x$doi <- fp_clean_doi(x$doi)
    x$display_name <- fp_shorten_string(x$display_name)
  } else {
    x <- data.frame(
      display_name = character(),
      publication_year = integer(),
      source_display_name = character(),
      doi = character()
    )
  }

  x
}
