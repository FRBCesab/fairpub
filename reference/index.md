# Package index

## Fairness and citation metrics

Functions to retrieve the fairness status of an article/journal and to
compute the citation ratio from a list of articles.

- [`fp_get_article_fairness()`](https://frbcesab.github.io/fairpub/reference/fp_get_article_fairness.md)
  : Get the fairness status of an article
- [`fp_get_journal_fairness()`](https://frbcesab.github.io/fairpub/reference/fp_get_journal_fairness.md)
  : Get the fairness status of a journal
- [`fp_compute_citation_ratio()`](https://frbcesab.github.io/fairpub/reference/fp_compute_citation_ratio.md)
  : Non profit & academic friendly ratio of citations

## OpenAlex API interface

Functions to query the OpenAlex database and retrieve bibliographic
information about authors, journals and publications.

- [`fp_get_openalex_author_id()`](https://frbcesab.github.io/fairpub/reference/fp_get_openalex_author_id.md)
  : Get OpenAlex author ID
- [`fp_get_openalex_author_works()`](https://frbcesab.github.io/fairpub/reference/fp_get_openalex_author_works.md)
  : Get and filter an author's works from OpenAlex
- [`fp_get_openalex_doi()`](https://frbcesab.github.io/fairpub/reference/fp_get_openalex_doi.md)
  : Get OpenAlex publication DOI
- [`fp_list_openalex_work_types()`](https://frbcesab.github.io/fairpub/reference/fp_list_openalex_work_types.md)
  : List valid OpenAlex work types
- [`fp_identify_duplicate_works()`](https://frbcesab.github.io/fairpub/reference/fp_identify_duplicate_works.md)
  : Identify duplicate works based on title similarity

## DOI utilities

Functions to extract and clean DOIs from BibTeX files or character
vectors.

- [`fp_extract_doi()`](https://frbcesab.github.io/fairpub/reference/fp_extract_doi.md)
  : Extract DOI from a BibTeX file or a string
- [`fp_clean_doi()`](https://frbcesab.github.io/fairpub/reference/fp_clean_doi.md)
  : Clean a DOI vector

## DAFNEE database

Function to retrieve the list of journals included in the DAFNEE
database.

- [`fp_list_dafnee_journals()`](https://frbcesab.github.io/fairpub/reference/fp_list_dafnee_journals.md)
  : List DAFNEE journals
