# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

# How to load into environment
# source("./R/CFU.R")

# I know you're not supposed to load data here - will address later
# Load data ----------------------------------------------
# library(readr)
# library(dplyr)
# library(stats)
# library(ggplot2)
# library(ggpubr)
# library(broom)
# library(purrr)
# library(tidyr)
# # -------------------------------------------------------
#
# # tidy up the excel file
# tidy_CFU <- function(csv, group_names) {
#   read_csv(csv) %>%
#     rename(Day = Timepoint) %>%
#     group_by(Organ, Day) %>%
#     mutate(Mouse = factor(Mouse, levels = group_names))
# }
#
# tidy_aov <- function(CFU_tidied) {
#   CFU_tidied %>%
#     nest() %>%
#     mutate(aov_result = map(data, ~aov(CFU ~ Mouse, data = .x)),
#            tukey_result = map(aov_result, TukeyHSD),
#            tidy_tukey = map(tukey_result, tidy)) %>%
#     unnest(tidy_tukey, .drop = TRUE)
# }
#
# # Find significance of anova results -------------------------------
# find_signif <- function(anova_results) {
#
#   signif_data <- anova_results %>%
#     filter(adj.p.value < 0.05) %>%
#     separate(col = comparison, into = c("group1", "group2"),
#              sep = "-") %>%
#     mutate(rounded = round(adj.p.value, digits = 4))
#
#   signif_data <- signif_data %>%
#     mutate(star = rep("*", nrow(signif_data)))
#
#   print(signif_data)
# }
# # -----------------------------------------------------------
#
# # Plot data -------------------------------------------------
# plot_CFU <- function(tidy_data, signif_data) {
#
#   ggline(x = "Mouse", y = "CFU", color = "Mouse", alpha = 0.5,
#          add = c("mean_se", "jitter"), data = tidy_data,
#          font.label = list(size = 30, face = "plain")) +
#     facet_wrap(c("Organ", "Day"), ncol = length(unique(tidy_data$Day)),
#                labeller = label_both) +
#     stat_pvalue_manual(data = signif_data,
#                        label = "star",
#                        xmin = "group1", xmax = "group2",
#                        y.position = c(max(tidy_data$CFU) -.5, max(tidy_data$CFU) + 0.25, max(tidy_data$CFU) + 1)) +
#     xlab("Mouse Strain") +
#     ylab("log 10 CFU") +
#     ylim(0,8.5) +
#     theme_bw()
#
# }

# tidy_CFU_file <- tidy_CFU("./Data/BCG_Survival_CFUs.csv", c("Fej", "Ouj", "BL6", "NOS"))
# aov_comp <- tidy_aov(tidy_CFU_file)
# signif <- find_signif(aov_comp)
# plot_CFU(tidy_CFU_file, signif)
