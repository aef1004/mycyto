#' Visualize the total number of identified populations
#'
#' @param df for which you want to visualize the total number of different populations
#'
#' @export
#'
heatmap_all_pheno <- function(df) {
  pheatmap(df, cluster_rows = FALSE, cluster_cols = FALSE,
                              color = viridis_colors, show_rownames = FALSE, legend = F, fontsize = 12, angle_col = 45, width = 2, height = 1.5)
}
