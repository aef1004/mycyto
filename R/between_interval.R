# this function is from OpenCyto Github RGLab https://github.com/RGLab/openCyto/blob/0ec1218427627b9ee092f8d39e6ab46d46e7e2f8/R/bayes-flowClust.R

between_interval <- function(x, interval) {
  x <- x[findInterval(x, interval) == 1]
  if (length(x) == 0) {
    x <- NA
  }
  x
}
