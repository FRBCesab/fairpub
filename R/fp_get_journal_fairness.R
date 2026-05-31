#' Get the fairness status of a journal
#'
#' @description
#' By querying the OpenAlex bibliographic database (<https://openalex.org>) and
#' the DAFNEE database (<https://dafnee.isem-evolution.fr/>), this function
#' returns the business model and the academic friendly status of a journal.
#'
#' @param journal a `character` of length 1. The name of the journal. Do not use
#'   journal abbreviation.
#'
#' @return A `data.frame` with two columns: `journal`, the journal name, and
#' `fairness`, the fairness status with the following possible values:
#'   - Non-profit and academic friendly
#'   - For-profit and academic friendly
#'   - For-profit and non academic friendly
#'   - Record not found in OpenAlex
#'   - Record not found in DAFNEE database
#'
#' @export
#'
#' @examples
#' # Be polite and send your email to OpenAlex API ----
#' options(openalexR.mailto = 'anonymous@mail.com')
#'
#' \dontrun{
#' # Fairness status ----
#' fp_get_journal_fairness("Science")
#' #>   journal                           fairness
#' #> 1 Science   Non-profit and academic friendly
#'
#' # Fuzzy search ----
#' fp_get_journal_fairness("Science of Nature")
#' #> No exact match found!
#' #> The fuzzy search returns these three best candidates:
#' #>   'The Science of Nature'
#' #>   'Science Advances'
#' #>   'People and Nature'
#'
#' fp_get_journal_fairness("The Science of Nature")
#' #>                 journal                               fairness
#' #> 1 The Science of Nature   For-profit and non-academic friendly
#' }

fp_get_journal_fairness <- function(journal = NULL) {
  assert_string(journal, "journal")

  ## Clean journal name ----

  journal <- tolower(journal)

  ## Query Dafnee (internal dataset) ----

  dafnee$"journal" <- dafnee$"oa_source_name"
  dafnee$"journal" <- tolower(dafnee$"journal")

  ## Exact match ----

  results <- dafnee[dafnee$"journal" == journal, ]

  if (nrow(results) > 0) {
    results <- results[1, ]

    if (results$"business_model" == "NP") {
      return(
        data.frame(
          "journal" = results[1, "oa_source_name"],
          "fairness" = "Non-profit and academic friendly"
        )
      )
    }

    if (results$"business_model" == "FP") {
      if (results$"academic_friendly" == "yes") {
        return(
          data.frame(
            "journal" = results[1, "oa_source_name"],
            "fairness" = "For-profit and academic friendly"
          )
        )
      }

      if (results$"academic_friendly" == "no") {
        return(
          data.frame(
            "journal" = results[1, "oa_source_name"],
            "fairness" = "For-profit and non-academic friendly"
          )
        )
      }
    }
  }

  ## Fuzzy search ----

  fuzzy <- stringdist::stringdist(journal, dafnee$"journal")
  suggestions <- dafnee[order(fuzzy, decreasing = FALSE), "oa_source_name"]
  suggestions <- suggestions[1:3]

  ## Print message ----

  msg <- paste0("  '", paste0(suggestions, collapse = "'\n  '"), "'")

  message(
    paste0(
      "No exact match found!\nThe fuzzy search returns these three best ",
      "candidates:\n",
      msg
    )
  )

  invisible(
    data.frame(
      "journal" = NA,
      "fairness" = NA
    )
  )
}
