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
