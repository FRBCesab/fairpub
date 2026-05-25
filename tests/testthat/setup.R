# Setup vcr ----

vcr::vcr_configure(
  dir = file.path(getwd(), "_vcr"),
  log = FALSE,
  log_opts = list(file = "console")
)


# Data for tests ----

filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

refs <- fp_read_bibtex(filename)

dois <- c(
  "10.1126/science.162.3859.1243",
  "10.1038/35002501",
  "https://doi.org/10.1111/j.1461-0248.2005.00792.x",
  "https://doi.org/10.xxxx/xxxx",
  "10.21105/joss.09217",
  NA
)

doi_to_clean <- c(
  "10.1098/rsos.160384",
  "10.1098/RSOS.160384",
  "doi:10.1098/rsos.160384",
  "doi: 10.1098/rsos.160384",
  "http://doi.org/10.1098/rsos.160384",
  "http://dx.doi.org/10.1098/rsos.160384",
  "https://doi.org/10.1098/rsos.160384",
  "HTTPS://DOI.ORG/10.1098/RSOS.160384",
  "https://dx.doi.org/10.1098/rsos.160384",
  "HTTPS://DX.DOI.ORG/10.1098/RSOS.160384",
  " https://dx.doi.org/10.1098/rsos.160384",
  "https://dx.doi.org/10.1098/rsos.160384 ",
  " https://dx.doi.org/10.1098/rsos.160384 ",
  NA
)

doi_na <- NA_character_
doi_not_in_oa <- "https://doi.org/10.xxxx/xxxx"
doi_not_in_dafnee <- "10.5281/zenodo.7390791"

journals <- c(
  "Science",
  "Science of Nature",
  "The Science of Nature",
  "Ecology Letters"
)

journal_na <- NA_character_

texte <- c(
  "Beck M (2026) Citation self-awareness... 10.1093/biosci/biag028.",
  "Galtier N (2026) Time to publish... DOI: 10.32942/X24933",
  "Doe J (9999) Title... http://dx.doi.org/10.1162/qss(c)_00305",
  "Receveur A (2024) David vs Goliath... https://doi.org/10.1111/ele.14395",
  "Smith J (9999) This is a fake article."
)

article_title <-
  "Citation self-awareness for a fairer academic publishing landscape"

orcid <- "https://orcid.org/0000-0002-5537-5294"
oa_id <- "https://openalex.org/A5004806463"
