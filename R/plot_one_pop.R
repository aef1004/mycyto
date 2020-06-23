#' This function will plot the timeseries and CFU regression plot for one population
#'
#' @param CFU_df the dataframe used to create the previous CFU regression plots
#' @param timeseries_df the dataframe used to create the previous time series plots
#' @param pop_no this should be the population number written in parenthesis
#'
#' @example plot_one_pop(facets_for_CFUs, facets_for_timeseries, "Pop3")
#' @export
#'
plot_one_pop <- function(CFU_df, timeseries_df, pop_no) {

  pop_pick <- CFU_df %>%
    filter(population == pop_no)

  CFU_one_plot <- ggplot(pop_pick, aes(percentage, CFU)) +
    geom_rect(aes(fill = col),xmin = -Inf,xmax = Inf,
              ymin = -Inf,ymax = Inf, alpha = 0.05) +
    scale_fill_identity() +
    geom_point(color = "black", size = 4) +
    geom_smooth(method = "lm", se = FALSE, color = "#3F4788FF") +
    stat_smooth_func(geom= "text", method = "lm", hjust = 0, parse = TRUE, color = "white", size = 8) +
    xlab("Percentage of Cells") +
    ylab("log10 CFU") +
    ggtitle("CFU Linear regression") +
    theme(axis.text.x = element_text(size = 11, hjust = 1),
          axis.text.y = element_text(size = 11),
          axis.title = element_text(size = 15),
          title = element_text(size = 16))

  pop_timeseries <- timeseries_df  %>%
    filter(population == pop_no)

  timeseries_one_plot <- ggplot(pop_timeseries, aes(x = factor(Timepoint, levels = c("30", "60", "90")),
                                                    y = average_percent, group = Group, color = Group)) +
    geom_rect(aes(fill = col),xmin = -Inf,xmax = Inf,
              ymin = -Inf,ymax = Inf, alpha = 0.2) +
    scale_fill_identity() +
    geom_point(size = 4) +
    geom_line(size = 2) +
    xlab("Days Post-Infection") +
    ylab("Average Percent of Total Live Leukocytes") +
    ggtitle(pop_no) +
    scale_color_manual(values = c("black", "white")) +
    theme_gray() +
    theme(axis.text.x = element_text(angle = 45, size = 11, hjust = 1),
          axis.text.y = element_text(size = 11),
          strip.text.x = element_text(size = 10),
          axis.title = element_text(size = 17),
          title = element_text(size = 16),
          legend.text = element_text(size=14),
          legend.key.size = unit(1, "line"),
          legend.position = "bottom")
  require(gridExtra)
  return(grid.arrange(timeseries_one_plot, CFU_one_plot, ncol = 2))

}
