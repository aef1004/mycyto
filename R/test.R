# tidy up the excel file
testing <- function(csv, group_names) {
  read_csv(csv) %>%
    rename(Day = Timepoint) %>%
    group_by(Organ, Day) %>%
    mutate(Mouse = factor(Mouse, levels = group_names)) %>%
    nest() %>%
    mutate(aov_result = map(data, ~aov(CFU ~ Mouse, data = .x)),
           tukey_result = map(aov_result, TukeyHSD),
           tidy_tukey = map(tukey_result, tidy)) %>%
    unnest(tidy_tukey, .drop = TRUE)
}
