# Setup vcr ----

vcr::vcr_configure(
  dir = file.path(getwd(), "_vcr"),
  log = FALSE,
  log_opts = list(file = "console")
)
