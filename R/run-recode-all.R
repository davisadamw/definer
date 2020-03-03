#' Recode all columns in a dataset using a definitions list
#'
#' Column names in \code{values_tbl} should match names in \code{def_list}
#'
#' @param values_tbl A data frame with values stored in a coded format.
#' @inheritParams def_recode
#'
#' @return A data frame with the same rows and columns as \code{values_tbl}, with columns recoded according to \code{def_recode}
#' @export
#'
#' @examples
#' def_list <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
#'                            value      = c(1,   2,   1,   2,   1),
#'                            definition = c('cat', 'dog', 'fred', 'george', 'lonely')) %>%
#'   def_prep(variable, value, definition, drop_solos = FALSE)
#'
#' source_data <- tibble::tibble(ID = c('A1', 'A2', 'A3'),
#'                               A  = c(1, 1, 2),
#'                               B  = c(2, 1, 2),
#'                               C  = c(1, 1, 1))
#'
#' def_recode_all(source_data, def_list)
def_recode_all <- function(values_tbl, def_list, .default = NULL, .missing = NULL) {
  # apply names map ... imap will iterate over columns, giving vector as first arg, col name as second arg
  # col name will get used to select the appropriate definition set
  values_tbl %>%
    purrr::imap(def_recode_pick, def_list, .default = .default, .missing = .missing) %>%
    tibble::as_tibble()
}
