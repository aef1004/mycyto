#' Calculate the total number of identified populations
#'
#' @param df that you want to calculate the total number of different populations
#' @param ... the markers that you want to look at for the different populations
#'
#' @export

calc_tot <- function(df, marker_vector) {
  df %>%
    select(-filename, -percentage, -cell_no, -total_count_by_file) %>%
    group_by_(marker_vector) %>%
    unique() %>%
    ungroup() %>%
    select(marker_vector) %>%
    mutate_all(~as.numeric.factor(.))
}
