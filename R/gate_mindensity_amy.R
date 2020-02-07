#this is a function that I adapted from <https://github.com/RGLab/openCyto/blob/0ec1218427627b9ee092f8d39e6ab46d46e7e2f8/R/bayes-flowClust.R> the difference between the original mindensity function and mine is that the original only works with a flowframe, while mine performs the same function on a dataframe. Mine also prints out the cutpoint so we can see it.

gate_mindensity_amy <- function(df, channel, filterId = "", positive = TRUE,
                                pivot = FALSE, gate_range = NULL, min = NULL, max = NULL,
                                peaks = NULL, ...) {

  if (missing(channel) || length(channel) != 1) {
    stop("A single channel must be specified.")
  }

  # Filter out values less than the minimum and above the maximum, if they are
  # given.

  # I altered this to take in a dataframe rather than fcs file
  x <- df[, channel]

  if(is.null(peaks))
    peaks <- find_peaks(x)[, "x"]

  if (is.null(gate_range)) {
    gate_range <- c(min(x), max(x))
  } else {
    gate_range <- sort(gate_range)
  }



  # In the special case that there is only one peak, we are conservative and set
  # the cutpoint as min(x) if 'positive' is TRUE, and max(x) otherwise.
  if (length(peaks) == 1) {
    cutpoint <- ifelse(positive, gate_range[1], gate_range[2])
  } else {
    # The cutpoint is the deepest valley between the two peaks selected. In the
    # case that there are no valleys (i.e., if 'x_between' has an insufficient
    # number of observations), we are conservative and set the cutpoint as the
    # minimum value if 'positive' is TRUE, and the maximum value otherwise.
    valleys <- try(find_valleys(x), silent = TRUE)
    valleys <- between_interval(x = valleys, interval = gate_range)

    if (any(is.na(valleys))) {
      #FIXME:currently it is still returning the first peak,
      #we want to pass density instead of x_between to 'min'
      #because x_between is the signal values
      cutpoint <- ifelse(positive, gate_range[1], gate_range[2])
    } else if (length(valleys) == 1) {
      cutpoint <- as.vector(valleys)
    } else if (length(valleys) > 1) {
      # If there are multiple valleys, we determine the deepest valley between
      # the two largest peaks.
      peaks <- sort(peaks[1:2])
      cutpoint <- between_interval(valleys, peaks)[1]

      # If none of the valleys detected are between the two largest peaks, we
      # select the deepest valley.
      if (is.na(cutpoint)) {
        cutpoint <- valleys[1]
      }
    }
  }
  gate_coordinates <- ifelse(positive, list(c(cutpoint, Inf)), list(c(-Inf, cutpoint)))

  names(gate_coordinates) <- channel

  rectangleGate(gate_coordinates, filterId = filterId)

  # I added in the print(cutpoint)
  print(cutpoint)

}
