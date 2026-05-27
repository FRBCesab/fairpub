#' Identify duplicate works based on title similarity
#'
#' Groups potentially duplicate bibliographic records by computing
#' pairwise string distances between work titles and clustering
#' similar items.
#'
#' @param data a `data.frame` containing at least a `title` column.
#'
#' @param string_dist a `character` string specifying the distance
#'   metric used by [stringdist::stringdistmatrix()]. Defaults to `"lv"`
#'   (Levenshtein distance).
#'
#' @param hclust_method a `character` string specifying the hierarchical
#'   clustering method used by [stats::hclust()].
#'   Defaults to `"single"`.
#'
#' @param threshold a `numeric` value controlling cluster separation.
#'   Lower values produce more fine-grained clusters (stricter matching),
#'   while higher values merge more records into the same group.
#'
#' @return The input `data.frame` with an additional column:
#'   \describe{
#'     \item{ref_id}{Integer cluster identifier grouping similar titles.}
#'   }
#'
#' @details
#' Title similarity is computed after basic text normalization
#' (lowercasing, punctuation removal, whitespace trimming).
#' Distances are calculated using [stringdist::stringdistmatrix()] and
#' normalized by title length before hierarchical clustering.
#'
#' This function does not remove duplicates but assigns a cluster
#' identifier that can be used for downstream deduplication or grouping.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' df <- data.frame(
#'   title = c(
#'     "Deep Learning for NLP",
#'     "Deep learning for natural language processing",
#'     "Quantum Computing Basics"
#'   )
#' )
#'
#' fp_identify_duplicate_works(df)
#' }

fp_identify_duplicate_works <- function(
  data,
  string_dist = "lv",
  hclust_method = "single",
  threshold = 0.2
) {
  x <- data[["title"]]

  x[is.na(x)] <- ""

  x <- tolower(x)
  x <- gsub("[[:punct:]]", " ", x)
  x <- gsub("[[:space:]]+", " ", x)
  x <- trimws(x)

  char_dist <- stringdist::stringdistmatrix(x, x, method = string_dist)

  dist_rel <- char_dist / outer(nchar(x), nchar(x), pmax)
  dist_rel[is.na(dist_rel)] <- 0

  hc <- stats::hclust(stats::as.dist(dist_rel), method = hclust_method)

  data[["ref_id"]] <- stats::cutree(hc, h = threshold)
  data
}
