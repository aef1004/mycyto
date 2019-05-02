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

library(readr)
library(dplyr)
library(stats)
library(ggplot2)
library(ggpubr)
library(broom)
library(purrr)
library(tidyr)

tidy_CFU_data <- function(csv) {
  read_csv(csv) %>%
    rename(Day = Timepoint) %>%
    group_by(Organ, Day) %>%
    mutate(Mouse = factor(Mouse, levels = group_names))

}

aov_tukey <- function(tidy_data) {
  tidy_data %>%
    nest() %>%
    mutate(aov_result = map(data, ~aov(CFU ~ Mouse, data = .x)),
           tukey_result = map(data, ~aov_result, TukeyHSD),
           tidy_tukey = map(tukey_result, tidy)) %>%
    unnest(tidy_tukey, .drop = TRUE)
}

find_signif <- function(anova_results) {

  signif_data <- anova_results %>%
    filter(adj.p.value < 0.05) %>%
    separate(col = comparison, into = c("group1", "group2"),
             sep = "-") %>%
    mutate(rounded = round(adj.p.value, digits = 4))

  signif_data <- signif_data %>%
    mutate(star = rep("*", nrow(signif_data)))

  print(signif_data)
}

plot_CFU <- function(tidied_data, signif_data) {

  ggline(x = "Mouse", y = "CFU", color = "Mouse", alpha = 0.5,
         add = c("mean_se", "jitter"), data = tidy_CFU,
         font.label = list(size = 30, face = "plain")) +
    facet_wrap(c("Organ", "Day"), ncol = length(unique(tidy_CFU$Day)),
               labeller = label_both) +
    stat_pvalue_manual(data = signif_data,
                       label = "star",
                       xmin = "group1", xmax = "group2",
                       y.position = c(5, 6.25, 7.25)) +
    xlab("Mouse Strain") +
    ylab("log 10 CFU") +
    ylim(0,8) +
    theme_bw()

}


