#' @param gated_data data frame that contains the data to find the minimum density between peaks
#'
#'
#' @export
#'
#'   initialize the gated data df

#' convert the gated flow files to dataframes and add a filename column


convert_gated_flow <- function(gated_data) {

  all_gated_df = data.frame()

for (i in 1:length(gated_data)) {
  all_data <- gated_data[[i]] %>%
    exprs() %>%
    data.frame() %>%
    mutate(filename = sampleNames(gated_data[i]))

  all_gated_df <- rbind(all_gated_df, all_data)

  return(all_gated_df)
}
}

