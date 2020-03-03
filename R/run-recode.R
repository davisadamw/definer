#' Recode a single vector or return vector unchanged
#'
#' Replaces numeric or character values in \code{vector} with matching entries from a named
#' vector or list provided in \code{definitions}.
#'
#'   * \code{def_recode()} Recodes a vector based on a set of value definitions provided directly.
#'   * \code{def_recode_pick()} Recodes a vector based on a set of value definitions chosen from a list of definition sets.
#'
#' This function is essentially equivalent to running \code{dplyr::\link[dplyr]{recode}(.x, !!!definitions)} but
#' returns the original values if it is called with an empty definitions set.
#'
#' @param .x A vector to modify
#' @param definitions A named vector or named list of replacement values, probably one entry in a dictionary
#'    produced by \code{\link{def_prep}()}. If this explicitly passed \code{null}, \code{.x} will be returned as is
#' @param def_name Scalar character matching a name in \code{def_list}.
#'   Which set of definitions should be pulled out of \code{def_list}?
#' @param def_list A list of definition sets, likely produced by \code{\link{def_prep}()}.
#' @param .default If supplied, all values not otherwise matched will be given this value.
#'    If not supplied and if the replacements are the same type as the original values in .x,
#'    unmatched values are not changed. If not supplied and if the replacements are not compatible,
#'    unmatched values are replaced with NA.
#'
#'    .default must be either length 1 or the same length as .x.
#' @param .missing If supplied, any missing values in .x will be replaced by this value. Must be either
#'    length 1 or the same length as .x.
#'
#' @return Vector of same length and order as \code{.x}, but with values drawn from \code{definitions}
#' @export
#'
#' @examples
#' definitions <- tibble::tibble(
#'   variable   = c('A', 'A', 'A'),
#'   value      = c(1,   2,   3),
#'   definition = c('cat', 'dog', 'fish')
#' ) %>%
#'   def_prep(variable, value, definition)
#'
#' def_recode(1:3, definitions$A)
#' # is equivalent to
#' def_recode_pick(1:3, 'A', definitions)
#'
#' # or, using dplyr code directly:
#' dplyr::recode(1:3, !!!definitions$A)
#' # or
#' dplyr::recode(1:3, 'cat', 'dog', 'fish')
#'
#' # Note that using an empty / NULL definition set returns the original vector unchanged
#' def_recode(1:3, definitions$Z)
#' def_recode_pick(1:3, 'Z', definitions)
def_recode <- function(.x, definitions,
                       .default = NULL, .missing = NULL) {
  if (is.null(definitions)) return(.x)

  dplyr::recode(.x, !!!definitions, .default = .default, .missing = .missing)
}


#' @export
#' @rdname def_recode
def_recode_pick <- function(.x, def_name, def_list,
                            .default = NULL, .missing = NULL) {
  def_recode(.x, purrr::pluck(def_list, def_name),
             .default = .default, .missing = .missing)
}

