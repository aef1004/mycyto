#'- `as.numeric.factor`: convert the factors for the marker names into numeric for plotting
#'[Amy: Why won't `as.numeric` work for this? That's a base R function that might avoid having to create this new function.]
#'
#'   @param x a vector of factors to be converted to numeric
#'
#' @export

as.numeric.factor <- function(x) {
  as.numeric(levels(x))[x]
  }
