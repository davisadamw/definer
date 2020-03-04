#' Get path to definer example data
#'
#' \code{definer} comes bundled with a number of example data definition files in its inst/extdata directory.
#'   This function make them easy to access. Adapted from \code{\link[readr]{readr_example}()}.
#'
#' @param path Name of file. If \code{NULL}, the example files will be listed.
#'
#' @export
#'
#' @examples
#' definer_example()
#' definer_example("ca_vehicle_survey_2019_definitions.xlsx")
definer_example <- function(path = NULL)
{
  if (is.null(path)) {
    dir(system.file("extdata", package = "definer"))
  }
  else {
    system.file("extdata", path, package = "definer", mustWork = TRUE)
  }
}
