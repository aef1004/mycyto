# this function is from OpenCyto Github RGLab https://github.com/RGLab/openCyto/blob/0ec1218427627b9ee092f8d39e6ab46d46e7e2f8/R/bayes-flowClust.R
find_valleys <- function(x, y = NULL, num_valleys = NULL, adjust = 2, ...) {

  x <- as.vector(x)

  if (length(x) < 2) {
    warning("At least 2 observations must be given in 'x' to find valleys.")
    return(NA)
  }

  if (is.null(y)) {
    dens <- density(x, adjust = adjust, ...)
  } else {
    y <- as.vector(y)
    if (length(x) != length(y)) {
      stop("The lengths of 'x' and 'y' must be equal.")
    }
    dens <- list(x = x, y = y)
  }

  # Discrete analogue to a second derivative applied to the KDE. See details.
  second_deriv <- diff(sign(diff(dens$y)))
  which_minima <- which(second_deriv == 2) + 1

  # The 'density' function can consider observations outside the observed range.
  # In rare cases, this can actually yield valleys outside this range. We remove
  # any such valleys.
  which_minima <- which_minima[findInterval(dens$x[which_minima], range(x)) == 1]

  # Next, we sort the valleys in descending order based on the density heights.
  which_minima <- which_minima[order(dens$y[which_minima], decreasing = FALSE)]

  # Returns the local minima. If there are none, we return 'NA' instead.
  if (length(which_minima) > 0) {
    valleys <- dens$x[which_minima]
    if (is.null(num_valleys) || num_valleys > length(valleys)) {
      num_valleys <- length(valleys)
    }
    valleys <- valleys[seq_len(num_valleys)]
  } else {
    valleys <- NA
  }
  valleys
}
