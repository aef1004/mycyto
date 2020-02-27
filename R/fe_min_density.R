#'Note that this specifically calls in the dataframe sampled_df - I will need to automate this
#' @param marker contains the marker
#' @param marker_name contains the name of the marker in quotations
#'
#' @return a numeric for the threshold cutoff point for a particular sample
#'
#' @example # convert dataframe with various
#' @export
#'
fe_min_density <- function(marker, marker_name) {
   cut(marker, breaks = c(min(marker), gate_mindensity_amy(all_gated_df, marker_name), max(marker)),
                        labels = c(0, 1))
 }



