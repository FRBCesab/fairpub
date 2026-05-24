#' Regex to detect DOI
#' @noRd
.DOI_REGEX <- paste0(
  "\\b",
  "(?:https?://(?:dx\\.)?doi\\.org/|doi:\\s*)?",
  "10\\.\\d{4,9}/[-._;()/:A-Z0-9]+[-A-Z0-9()]"
)


#' Regex for DOI prefix
#' @noRd
.DOI_PREFIX <- "^(https?://(?:dx\\.)?doi\\.org/|doi:\\s*)"
