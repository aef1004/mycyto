#' Calculates the cell counts and percentages for individual populations
#'
#' @param df1 dataframe that contains the samples, populations, and percentages

#'
#' @example corr <- calc_corr(sample_populations_all_groups)
#' @export


calc_corr <- function(df) {

  corr <- df %>%
    mutate(population= str_replace(population, "Pop", "")) %>%
    spread(key = population, value = percentage) %>%
    select(-filename) %>%
    select(c(paste0(1:ncol(.))))

  corr <- round(cor(corr), 1)

  return(corr)

}
