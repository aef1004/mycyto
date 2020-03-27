# #'Note that this specifically calls in the dataframe sampled_df - I will need to automate this
#' @param marker contains the marker
#' @param marker_name contains the name of the marker in quotations
#'
#' @return a numeric for the threshold cutoff point for a particular sample
#'
#' @example # convert dataframe with various
#' where add_quantile contains the information for where the quantile is located
#' all_gated_df %>%
#' mutate(CD11b = fe(add_quantile, CD11b, "CD11b")
#'
#' @export

fe <- function(quantile_df, marker, marker_name) {

  find_quantile <- quantile_df %>%
    filter(filename == marker_name) %>%
    select(quantile_99)

  cut(marker, breaks = c(min(marker), find_quantile, max(marker)),
      labels = c(0, 1))
}
