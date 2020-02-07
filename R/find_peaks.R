# this function is from OpenCyto Github RGLab https://github.com/RGLab/openCyto/blob/0ec1218427627b9ee092f8d39e6ab46d46e7e2f8/R/bayes-flowClust.R

find_peaks <- function(x, y = NULL, num_peaks = NULL, adjust = 2, plot = FALSE, ...) {
  x <- as.vector(x)

  if (length(x) < 2) {
    warning("At least 2 observations must be given in 'x' to find peaks.")
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
  which_maxima <- which(second_deriv == -2) + 1

  # The 'density' function can consider observations outside the observed range.
  # In rare cases, this can actually yield peaks outside this range.  We remove
  # any such peaks.
  which_maxima <- which_maxima[findInterval(dens$x[which_maxima], range(x)) == 1]

  # Next, we sort the peaks in descending order based on the density heights.
  which_maxima <- which_maxima[order(dens$y[which_maxima], decreasing = TRUE)]

  # Returns the local maxima. If there are none, we return 'NA' instead.
  if (length(which_maxima) > 0) {
    peaks <- dens$x[which_maxima]
    if (is.null(num_peaks) || num_peaks > length(peaks)) {
      num_peaks <- length(peaks)
    }
    peaks <- peaks[seq_len(num_peaks)]
  } else {
    peaks <- NA
  }

  peaks <- data.frame(x = peaks, y = dens$y[which_maxima][seq_len(num_peaks)])
  if(plot){
    plot(dens, main = paste("adjust =" ,  adjust))
    points(peaks, ,col = "red")
  }

  peaks
}
