#' Prepare dictionary structure from a data frame with columns identifying variable, value, and definition
#'
#' value map will be applied only when starting_value and ending_value are same
#' to do this, convert it into a nested list
#' ... list will have elements for columns in pums_hh, each one a named vector of potential values
#'
#' @param definitions_tbl A data frame containing information about the definitions of values stored in another table.
#' @param variable_col Unquoted name of column in `definitions_tbl` that identifies columns in the data table being cleaned
#' @param value_col Unquoted name of column in `definitions_tbl` that stores current values of variables identified by `variable_col`
#' @param definition_col Unquoted name of column in `definitions_tbl` that stores replacement / "definition" values matched to `value_col`
#' @param drop_solos Optionally, logical identifying whether to exclude variables from the dictionary if they only have one unique value
#'
#' @return Named list of vectors to use for recoding variables. Probably should be an S3 class.
#' @export
#'
#' @examples
#' tibble::tibble(variable   = c("A", "A", "B", "B", "C"),
#'                value      = c(1,   2,   1,   2,   1),
#'                definition = c("cat", "dog", "fred", "george", "lonely")) %>%
#'   def_prep(variable, value, definition)
def_prep <- function(definitions_tbl,
                     variable_col,
                     value_col,
                     definition_col,
                     drop_solos = TRUE) {

  # first, create a nested tibble with all the values for each variable grouped together
  definitions_tbl_nested <- definitions_tbl %>%
    dplyr::select({{ variable_col }},
                  {{ value_col }},
                  {{ definition_col }}) %>%
    dplyr::group_by({{ variable_col }}) %>%
    tidyr::nest(val_map_tbl = c({{ value_col }}, {{definition_col }}))

  # if drop_solos set to TRUE, remove all variables with a single unique value
  if (drop_solos) {
    definitions_tbl_nested <- definitions_tbl_nested %>%
      dplyr::filter(purrr::map_int(.data$val_map_tbl, nrow) != 1L)
  }

  definitions_tbl_nested %>%
    dplyr::mutate(val_map = purrr::map(.data$val_map_tbl, tibble::deframe)) %>%
    dplyr::select(-.data$val_map_tbl) %>%
    tibble::deframe()

}

