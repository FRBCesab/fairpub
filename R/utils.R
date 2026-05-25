#' Helper: if x is NULL then y
#' @noRd
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}


#' @noRd
fp_check_mailto <- function() {
  if (is.null(options()$"openalexR.mailto")) {
    stop(
      "Be polite with OpenAlex API and run: ",
      "`options(openalexR.mailto = 'your_email')`"
    )
  }

  invisible(NULL)
}

#' @noRd
fp_read_bibtex <- function(file) {
  bibtex::read.bib(file)
}


#' @noRd
fp_extract_doi_from_bibentry <- function(bibentry) {
  vapply(
    bibentry,
    \(x) x$doi %||% NA_character_,
    character(1),
    USE.NAMES = FALSE
  )
}


#' @noRd
fp_extract_doi_from_string <- function(x) {
  matches <- regmatches(
    x,
    gregexpr(.DOI_REGEX, x, perl = TRUE, ignore.case = TRUE)
  )

  unlist(matches, use.names = FALSE)
}


#' @noRd
fp_shorten_string <- function(x, width = 50) {
  is_short <- nchar(x) <= width

  shortened <- substr(x, 1, width - 3)
  shortened <- sub("\\s+\\S*$", "", shortened)
  shortened <- paste0(shortened, "...")

  ifelse(is_short, x, shortened)
}


#' @noRd
fp_clean_oa_id <- function(x) {
  gsub(.OA_PREFIX, "", x)
}


#' @noRd
fp_clean_orcid <- function(x) {
  gsub(.ORCID_PREFIX, "", x)
}
