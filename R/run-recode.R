#' Recode a single vector or return vector unchanged
#'
#' Replaces numeric or character values in \code{vector} with matching entries from a named
#' vector or list provided in \code{definitions}.
#'
#' This function is essentially equivalent to running \code{dplyr::\link[dplyr]{recode}(.x, !!!definitions)} but
#' returns the original values if it is called with an empty definitions set.
#'
#' @param .x A vector to modify
#' @param definitions A named vector or named list of replacement values, probably one entry in a dictionary
#'    produced by \code{\link{def_prep}()}. If this explicitly passed \code{null}, \code{.x} will be returned as is
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
def_recode <- function(.x, definitions,
                       .default = NULL, .missing = NULL) {
  if (is.null(definitions)) return(.x)

  dplyr::recode(.x, !!!definitions, .default = .default, .missing = .missing)
}


