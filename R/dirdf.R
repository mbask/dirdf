#' List Files in a Directory as a Data Frame
#'
#' Creates a data frame using information from paths and file names.
#' It searches through the directories in order to create the path names of the files.
#' It accepts either a \link[=templates]{template} or a regular expression and column names.
#'
#' @seealso \code{\link{dirdf_parse}}
#'
#' @inheritParams dirdf_parse
#'
#' @param paths character vector with zero or more paths that will be searched
#'
#' @param recursive if TRUE, it will recursively search over directories
#' @param ... Additional arguments pass to \code{\link[base]{dir}()}.
#'
#' @examples
#' \dontrun{
#' example_path <- system.file(package = "dirdf", "examples", "dataset_1")
#' example_template1 <- "Year-Month-Day_Assay_Plasmid-Type-Fraction_WellNumber.extension"
#' example_template2 <- "Date_Assay_Experiment_WellNumber.extension"
#'
#' dirdf(example_path1, template = example_template)
#' }
#'
#' @export
dirdf <- function(paths, template=NULL, regexp=NULL, colnames=NULL, missing=NA_character_, recursive=TRUE, ...) {
  if (!is.null(template)) {
    res <- templateToRegex(template)
    regexp <- res$pattern
    colnames <- res$names
  }

  pathnames <- lapply(paths, FUN=dir, recursive=recursive, ...)
  pathnames <- unlist(pathnames, use.names=FALSE)

  dirdf_parse(pathnames, colnames=colnames, regexp=regexp, missing=missing)
}
