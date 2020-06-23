#' Calculates the cell counts and percentages for individual populations
#'
#' This function
#'
#' @param df1 dataframe that contains the populations you want to look at (phenotype_data)
#' @param df2 dataframe that contains (all_gated)
#'
#' @example sample_populations_all_groups <- identified_pop_perc(df1 = phenotype_data, df2 = all_gated)
#' @export


identified_pop_perc <- function(df1, df2) {

  # convert the marker columns of factor class into numeric
  df2 <- df2 %>%
    mutate_if(is.factor, ~as.numeric.factor(.))

  # add the percentages from original data to the populations of filtered data
  add_perc <- left_join(df1, df2)

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
