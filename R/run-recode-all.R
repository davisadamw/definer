#' Recode all columns in a dataset using a definitions list
#'
#' @param values_tbl A data frame with values stored in a coded format
#' @param definitions A named list of named vectors to use for recoding variables.
#'
#' @return A data frame with the same rows and columns as \code{values_tbl}, with columns recoded according to \code{definitions}
#' @export
#'
#' @examples
def_recode_all <- function(values_tbl, definitions) {
  # apply names map ... imap will iterate over columns, giving vector as first arg, col name as second arg
  values_tbl %>%
    purrr::imap(def_recode, ) %>%
    tibble::as_tibble()
}
