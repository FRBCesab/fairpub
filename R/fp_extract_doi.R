#' Extract DOI from a BibTeX file
#'
#' @description
#' This function reads a BibTex file and extracts the DOI of references (if
#' originally present in the file).
#'
#' @param file a `character` of length 1. The (absolute or relative) path to
#'   the BibTeX file to open.
#'
#' @return
#' A `character` vector with extracted DOI. Some values can be `NA` in case of
#' books, chapters, etc. or if references are malformed.
#'
#' @export
#'
#' @examples
#' # Path to the BibTeX provided by <fairpub> ----
#' filename <- system.file(
#'   file.path("extdata", "references.bib"),
#'   package = "fairpub"
#' )
#'
#' # Extract DOI from BibTeX ----
#' fp_extract_doi(filename)

fp_extract_doi <- function(file) {
  check_arg_file(file)

  file |>
    fp_read_bibtex() |>
    fp_extract_doi_from_bibentry() |>
    fp_clean_doi()
}
