#' Get and filter an author's works from OpenAlex
#'
#' Queries the OpenAlex bibliographic database (<https://openalex.org>) to
#' retrieve works associated with an OpenAlex author identifier. Optionally
#' filters publication types and incomplete records.
#'
#' @param author_id a `character` of length 1. OpenAlex author ID. This
#'   identifier can be retrieved with [fp_get_openalex_author_id()].
#'
#' @param select a `character` vector of work types to retain. Use
#'   [fp_list_openalex_work_types()] to list valid work types.
#'   Defaults to `c("article", "review", "letter")`.
#'   Set to `NULL` to keep all work types.
#'
#' @param drop_na a `logical`. If `TRUE` (default), works with missing
#'   DOI or missing source information are removed.
#'
#' @return A data frame containing one row per work with the following
#'   columns:
#'   \describe{
#'     \item{id}{OpenAlex work identifier}
#'     \item{authors}{Work (first) author}
#'     \item{title}{Work title}
#'     \item{publication_year}{Year of publication}
#'     \item{source_display_name}{Journal or source name}
#'     \item{source_id}{OpenAlex source identifier}
#'     \item{doi}{Digital Object Identifier}
#'     \item{cited_by_count}{Citation count in OpenAlex}
#'     \item{type}{OpenAlex work type}
#'   }
#'
#' @details
#' This function is a wrapper around the OpenAlex API using the
#' `openalexR` package. Results are automatically standardized and
#' cleaned for downstream bibliometric analyses.
#'
#' Some repositories and preprint servers (e.g. Zenodo, HAL, bioRxiv, figshare)
#' may be excluded depending on the selected work types.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Be polite and send your email to OpenAlex API ----
#' options(openalexR.mailto = 'anonymous@mail.com')
#'
#' fp_get_openalex_author_works("A5004806463")
#' #>          id                    authors                               title
#' #> 1 W7143431770  Brunno F. Oliveira et al.     Species range shifts often...
#' #> 2 W7153879999         Miriam Beck et al.    Citation self-awareness for...
#' #> 3 W4406766122 Érica Rievrs Borges et al.         Road‐river intersectio...
#' #> 4 W4415048605   Jonathan Bonfanti et al. Geographic, taxonomic and metr...
#' #> 5 W4411408576      Matthew McLean et al.       Conserving the beauty of...
#' #> 6 W4415113473     Nicolas Casajus et al.           forcis: An R package...
#' #>   publication_year                             source_display_name
#' #> 1             2026 Proceedings of the National Academy of Sciences
#' #> 2             2026                                      BioScience
#' #> 3             2025                      Applied Vegetation Science
#' #> 4             2025                                 Ecology Letters
#' #> 5             2025 Proceedings of the National Academy of Sciences
#' #> 6             2025             The Journal of Open Source Software
#' #>     source_id                     doi cited_by_count    type
#' #> 1  S125754415 10.1073/pnas.2515903123              1 article
#' #> 2  S121830084  10.1093/biosci/biag028              0 article
#' #> 3  S179963793      10.1111/avsc.70011              0 article
#' #> 4   S80967739       10.1111/ele.70220              1  review
#' #> 5  S125754415 10.1073/pnas.2415931122              1 article
#' #> 6 S4210214273     10.21105/joss.09217              0 article
#' }

fp_get_openalex_author_works <- function(
  author_id = NULL,
  select = c("article", "review", "letter"),
  drop_na = TRUE
) {
  assert_string(author_id, "author_id")
  assert_starting_with(author_id, "A", "author_id")

  if (!is.null(select)) {
    assert_character(select, "select")
    assert_not_na(select, "select")
  }

  assert_flag(drop_na, "drop_na")

  assert_openalex_mailto()

  fp_oa_fetch_works(author_id) |>
    fp_oa_parse_works() |>
    fp_oa_filter_works(select, drop_na)
}


#' @noRd
fp_oa_fetch_works <- function(author_id) {
  meta <- tryCatch(
    suppressMessages(
      openalexR::oa_fetch(
        entity = "works",
        author.id = author_id,
        per_page = 200,
        paging = "cursor",
        abstract = FALSE
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
fp_oa_parse_works <- function(x) {
  cols <- c(
    "id",
    "authors",
    "title",
    "publication_year",
    "source_display_name",
    "source_id",
    "doi",
    "cited_by_count",
    "type"
  )

  if (nrow(x) > 0) {
    authors <- openalexR::show_works(x, simp_fun = identity)

    x$authors <- ifelse(
      is.na(authors[["last_author"]]),
      authors[["first_author"]],
      paste0(authors[["first_author"]], " et al.")
    )

    x <- x[, cols, drop = FALSE]

    x$id <- fp_clean_oa_id(x$id)
    x$source_id <- fp_clean_oa_id(x$source_id)
    x$doi <- fp_clean_doi(x$doi)
    x$source_display_name <- fp_clean_source(x$source_display_name)
  } else {
    x <- data.frame(
      id = character(),
      authors = character(),
      title = character(),
      publication_year = integer(),
      source_display_name = character(),
      source_id = character(),
      doi = character(),
      cited_by_count = integer(),
      type = character()
    )
  }

  x
}

#' @noRd
fp_oa_filter_works <- function(x, select, drop_na) {
  if (!is.null(select)) {
    assert_if_valid_work_type(select)

    x <- x[x$type %in% select, ]

    if (!("dataset" %in% select)) {
      x <- x[
        !(tolower(x$source_display_name) %in% c("zenodo", "figshare")),
      ]
    }

    if (!("preprint" %in% select)) {
      x <- x[
        !(tolower(x$source_display_name) %in%
          c("hal", "biorxiv", "ecoevorxiv")),
      ]
    }
  }

  if (drop_na) {
    x <- x[!is.na(x$doi) & !is.na(x$source_display_name), ]
  }

  x
}
