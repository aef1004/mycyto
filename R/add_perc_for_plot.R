#' @param phenotype_data dataframe that contains the phenotype information (sample_populations)
#' @param all_gated dataframe that contains (all_gated)
#'@export


add_perc_for_plot <- function(phenotype_data, all_gated) {

  # convert the marker columns of factor class into numeric
  all_gated <- all_gated %>%
    mutate_if(is.factor, ~as.numeric.factor(.))

  # add the percentages from original data to the populations of filtered data
  add_perc <- left_join(phenotype_data, all_gated)

  # expand the data so can see which files have 0 cells in a phenotype
  all_options <- expand(add_perc, population, filename)

  # add the populations back
  add_pops <- left_join(all_options, phenotype_data)

  # add the percentages back
  sample_populations_all_groups <- left_join(add_pops, all_gated) %>%
    select(population, filename, percentage) %>%
    mutate_all(list(~replace_na(., 0)))

  return(sample_populations_all_groups)
}
