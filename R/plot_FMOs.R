#' @param df1 the dataframe that contains the filtered FMO values (only the FMO file that matches up with it's marker)
#' @param df2 the dataframe that contains the quantile values
#'
#'
#' @export
#'
#'

plot_FMOs <- function(df1, df2) {

  right_quantile <- full_join(df1, df2, by = "filename")

  ggplot(right_quantile, aes(x = MFI, y = `SSC-A`)) +
    geom_hex(bins = 300, na.rm = TRUE) +
    scale_fill_viridis_c() +
    facet_wrap(~ marker, nrow = 3) +
    ylab("") +
    geom_vline(mapping = aes(xintercept = quantile_99)) +
    theme_gray() +
    theme(axis.text = element_text(size =12),
          axis.title = element_text(size = 20),
          strip.text = element_text(size = 12))+
    scale_x_continuous(labels = scientific, limits = c(-10000, 20000), breaks = c(0, 50000))

  }
