#' Calculates the cell counts and percentages for individual populations
#'
#' This function
#'
#' @param df1 dataframe that contains the populations you want to look at (phenotype_data or sampled_data)
#' @param df2 dataframe that contains (all_gated)
#' @param marker_vector vector that contains the markers columns that make up the populations
#'
#' @example sample_populations_all_groups <- identified_pop_perc(df1 = phenotype_data, df2 = all_gated, marker_vector = order_of_markers)
#' @export


identified_pop_perc <- function(df1, df2, marker_vector) {

  # add the percentages from original data to the populations of filtered data
  add_perc <- left_join(df1, df2, by = marker_vector)

  # expand the data so can see which files have 0 cells in a phenotype
  all_options <- expand(add_perc, population, filename)

  # add the populations back
  add_pops <- left_join(all_options, df1)

  # add the percentages back
  sample_populations_all_groups <- left_join(add_pops, df2) %>%
    select(population, filename, percentage) %>%
    mutate_all(list(~replace_na(., 0)))

  return(sample_populations_all_groups)
}
