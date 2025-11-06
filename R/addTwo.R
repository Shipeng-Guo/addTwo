#' Add two numbers
#'
#' @param x numeric, first addend
#' @param y numeric, second addend
#' @return numeric, sum of x and y
#' @examples
#' addTwo(1, 2) # 3
#' @export
addTwo <- function(x, y) {
  stopifnot(is.numeric(x), is.numeric(y), length(x) == 1, length(y) == 1)
  x + y
}

