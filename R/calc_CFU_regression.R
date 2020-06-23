#' This function will create a table of the r^2 values and p-values for the CFU regression plots
#'
#' @param CFU_df the dataframe used to create the previous CFU regression plots
#' @param adjustment this the the p-value adjustment method that you want to use
#'
#' @example calc_CFU_regression(facets_for_CFU, "BH")
#' @export

calc_CFU_regression <- function(CFU_df, adjustment) {
  fitted_models <- CFU_df %>%
    group_by(population) %>%
    do(model = lm(percentage ~ CFU, data = .)) %>%
    glance(model) %>%
    select(population, r.squared, p.value) %>%
    ungroup()

  fitted_models %>%
    mutate(p.val.adj = p.adjust(fitted_models$p.value, adjustment)) %>%
    mutate("Significance" = p.val.adj < 0.05) %>%
    rename("p-value" = p.value,
           "r squared" = r.squared,
           "Adjusted p-value" = p.val.adj) %>%
    kable(align = "c") %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"), font_size = 15) %>%
    row_spec(0:nrow(fitted_models), color = "black")
}
