plot_FMOs <- function(df, marker, marker_name){
  ggplot(right_quantile, aes(x = MFI, y = `SSC-A`)) +
    geom_hex(bins = 100, na.rm = TRUE) +
    scale_fill_viridis_c() +
    facet_wrap(~ marker, nrow = 3) +
    ylab("") +
    geom_vline(mapping = aes(xintercept = quantile_99)) +
    theme_gray()+
    theme(axis.text = element_text(size =12),
          axis.title = element_text(size = 20),
          strip.text = element_text(size = 12))+
    scale_x_continuous(labels = scientific, limits = c(-10000, 20000), breaks = c(0, 20000))
}
