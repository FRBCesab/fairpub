# fp_clean_*()

#' @noRd
fp_clean_oa_id <- function(x) {
  gsub(.OA_PREFIX, "", x)
}


#' @noRd
fp_clean_orcid <- function(x) {
  gsub(.ORCID_PREFIX, "", x)
}


#' @noRd
fp_clean_source <- function(x) {
  gsub("\\s\\(.*\\)", "", x)
}
