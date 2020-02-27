# #'Note that this specifically calls in the dataframe sampled_df - I will need to automate this
#' @param marker contains the marker
#' @param marker_name contains the name of the marker in quotations
#'
#' @return a numeric for the threshold cutoff point for a particular sample
#'
#' @example # convert dataframe with various

#'
#' fe <- function(marker, marker_name) {
#'   cut(marker, breaks = c(min(marker), quantile(), max(marker)),
#'      labels = c(0, 1))
#'}
