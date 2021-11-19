#' Filter for visualizing all the phenotypes
#'
#' @param df for which you want to visualize the total number of different populations
#' @param marker_order vector of the order you want the markers to be in for the plot
#'
#' @export
#'
#'

filter_for_total_pheno<- function(df, marker_order) {

  total_phenotypes <- df %>%
    select(-filename, -percentage, -cell_no, -total_count_by_file) %>%
    group_by_if(is.factor) %>%
    unique() %>%
    ungroup() %>%
    select(marker_order) %>%
    mutate_all(~as.numeric(.))

  return(total_phenotypes)
}
