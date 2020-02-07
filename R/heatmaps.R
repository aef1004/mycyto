
#
#
# phenotype_heatmap <- function(csv_file, population_no, title) {
#   pheatmap(csv_file, cluster_rows = FALSE, cluster_cols = FALSE,
#            labels_row = paste("Pop", population_no), main = title)
# }
#
#
# abundance_heatmap <- function(csv_file, population_no, title) {
#   pheatmap(csv_file, cluster_rows = FALSE, cluster_cols = FALSE,
#            labels_row = paste("Pop", population_no),
#            color = colorRampPalette(c("Yellow", "Maroon1"))(length(seq(0, 15, by = 1))),
#            main = title)
# }
#
#
# population_time_plot <- function(percentage_csv, population_no, group_names, title) {
#
#   percentage_csv <- read_csv(percentage_csv)
#   row.names(percentage_csv) <- c(paste("Pop", population_no))
#
#   percentage_csv <- percentage_csv %>%
#     add_rownames("Pop") %>%
#     gather(key = "Groups", value = "Percent", - "Pop")
#
#   print(percentage_csv)
#
#   ggplot(percentage_csv, aes(x = factor(Groups, levels = group_names),
#                   y = Percent, fill = Groups)) +
#     geom_histogram(stat = "identity") +
#     facet_wrap("Pop", scales = "free") +
#     xlab("Groups") +
#     ggtitle(title) +
#     theme(axis.text.x = element_text(angle = 45, size = 16, hjust = 1),
#           axis.text.y = element_text(size = 14),
#           strip.text.x = element_text(size = 14),
#           axis.title = element_text(size = 18),
#           title = element_text(size = 20))
# }
#
# # Example: population_time_plot(percentage_csv, 0:19, c("BL6 BCG", "Ouj BCG", " Fej BCG", "NOS BCG"),
#                      "BCG Survival")
#
#
