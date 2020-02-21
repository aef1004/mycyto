#'Note that this specifically calls in the dataframe sampled_df
#' @param marker contains the marker
#' @param marker_name contains the name of the marker in quotations
#' @export
#'
fe <- function(marker, marker_name) {
   cut(marker, breaks = c(min(marker), gate_mindensity_amy(sampled_df, marker_name), max(marker)),
                        labels = c(0, 1))
 }
