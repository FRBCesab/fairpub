#' List valid OpenAlex work types
#'
#' Returns the set of work types recognized by the OpenAlex database and used
#' for filtering bibliographic records.
#'
#' @return a `character` vector of valid OpenAlex work types.
#'
#' @details
#' These work types correspond to the classification system used by
#' OpenAlex to describe scholarly outputs. They can be used to filter
#' results in functions such as [fp_get_openalex_author_works()].
#'
#' @export
#'
#' @examples
#' fp_list_openalex_work_types()

fp_list_openalex_work_types <- function() {
  c(
    "article",
    "book",
    "book-chapter",
    "dataset",
    "dissertation",
    "editorial",
    "erratum",
    "letter",
    "libguides",
    "other",
    "paratext",
    "peer-review",
    "preprint",
    "reference-entry",
    "report",
    "retraction",
    "review",
    "standard",
    "supplementary-materials"
  )
}
