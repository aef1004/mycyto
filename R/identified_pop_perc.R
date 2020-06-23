#' Calculates the cell counts and percentages for individual populations
#'
#' This function
#'
#' @param df1 dataframe that contains the populations you want to look at (sample_populations)
#' @param df2 dataframe that contains (all_gated)
#'@export


identified_pop_perc <- function(sample_populations, all_gated) {

  # add in the percentage of cells in each specific population after the filter
  test <- left_join(sample_populations, all_gated)

  # expand to add in the data where a mouse may have 0 cells in a certain population identified after the filter
  all_options <- expand(test, population, filename)

  # add in the population information
  add_pops <- left_join(all_options, sample_populations)

  # add populations to the original gated data and replace NA percentages with 0
  sample_populations_all_groups <- left_join(add_pops, all_gated) %>%
    select(population, filename, percentage) %>%
    mutate_all(list(~tidyr::replace_na(.,0)))

  return(sample_populations_all_groups)
}
