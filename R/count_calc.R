#' Calculates the cell counts and percentages for individual populations
#'
#' This function
#'
#' @param df dataframe to calculate the cell counts and percentages
#' @param marker_vector a vector of column names to group to calculate the cell counts and percentages
#'
#' @note  I could make the default to use every column*
#'  example of marker vector: column <- c("CD4", "CD11B", "MHCII", "CD3", "CD45", "CD19", "CD25", "CCR2", "KLRG1", "CD8", "CD11C", "CCR7", "CD62L", "NK1.1", "Ly6G", "CD103", "PD1", "CD127", "GDTCR", "Ly6C", 'CD44')
#'  @export

count_calc <- function(df) {
  df %>%
  dplyr::mutate(cell_no = n()) %>%
  unique() %>%
  ungroup() %>%
  dplyr::group_by(filename) %>%
  dplyr::mutate(total_count_by_file = sum(cell_no),
                percentage = (100*cell_no / total_count_by_file)) %>%
  ungroup()
}



