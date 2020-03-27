#'Note that this specifically calls in the dataframe sampled_df - I will need to automate this
#' @param marker contains the marker
#' @param marker_name contains the name of the marker in quotations
#'
#' @return a numeric for the threshold cutoff point for a particular sample
#'
#' @example # convert dataframe with various
#'
#' all_gated_df %>%
#' mutate(CD4 = fe_min_density(all_gated_df, all_gated_df$CD4, "CD4"))
#'
#' @export
#'
fe_min_density <- function(df, marker, marker_name) {
  cut(marker, breaks = c(min(marker), gate_mindensity_amy(df, marker_name), max(marker)),
      labels = c(0, 1))
}



