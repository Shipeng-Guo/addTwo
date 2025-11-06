#' Subtract two numbers
#'
#' @param x numeric, minuend
#' @param y numeric, subtrahend
#' @return numeric, difference x - y
#' @examples
#' minusTwo(5, 3) # 2
#' @export
minusTwo <- function(x, y) {
  stopifnot(is.numeric(x), is.numeric(y), length(x) == 1, length(y) == 1)
  x - y
}

