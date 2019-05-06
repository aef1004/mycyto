
library(flowCore)
library(FlowSOM)
library(dplyr)
library(ggplot2)
library(stringr)
library(purrr)
library(pheatmap)
library(tidyr)


clean_FCS <- function(fcs_file) {
  read.FCS(fcs_file) %>%
    exprs() %>%
    data.frame() %>%
    select(ends_with(".A"), -`SSC.A`, -`FSC.A`) %>%
    rename(`CXCR3` = "APC.A",
           `CD44` = "APC.Fire.750.A",
           `CD103` =  "APC.R700.A",
           `CD3` = "Alexa.Fluor.532.A",
           `Sca1` = "BB515.A",
           `CCR7` = "BV421.A",
           `CD4` = "BV480.A",
           `CD69` = "BV510.A",
           `CD8` = "BV570.A",
           `CTLA4` = "BV605.A",
           `CD27` = "BV650.A",
           `CD153` = "BV711.A",
           `KLRG1` = "BV785.A",
           `CXCR1` = "PE.A",
           `CD122` = "PE.Cy5.A",
           `PD1` = "PE.Cy7.A",
           `CD62L` = "PE.Dazzle594.A",
           `CD45RB` = "Pacific.Blue.A",
           `CD28` = "PerCP.Cy5.5.A",
           `CXCR5` = "PerCP.eFluor.710.A")
}

phenotype_heatmap <- function(csv_file, population_no, title) {
  pheatmap(csv_file, cluster_rows = FALSE, cluster_cols = FALSE,
           labels_row = paste("Pop", population_no), main = title)
}

feature_cut <- function(fcs_file) {
  clean_FCS(fcs_file) %>%
    mutate(CD3_cut = cut(CD3, breaks = c(min(CD3), quantile(CD3_FMO$CD3, 0.99), max(CD3)),
                         labels = c("0", "1")),
           CD4_cut = cut(CD4, breaks = c(min(CD4), quantile(CD4_FMO$CD4, 0.99), max(CD4)),
                         labels = c(0, 1)),
           CD8_cut = cut(CD8, breaks = c(min(CD8), quantile(CD8_FMO$CD8, 0.99), max(CD8)),
                         labels = c(0, 1)),
           CD44_cut = cut(CD44, breaks = c(min(CD44), quantile(CD44_FMO$CD44, 0.99),
                                           max(CD44)), labels = c(0, 1)),
           CD103_cut = cut(CD103, breaks = c(min(CD103), quantile(CD103_FMO$CD103, 0.99),
                                             max(CD103)), labels = c(0, 1)),
           Sca1_cut = cut(Sca1, breaks = c(min(Sca1), quantile(Sca1_FMO$Sca1, 0.99),
                                           max(Sca1)), labels = c(0, 1)),
           CCR7_cut = cut(CCR7, breaks = c(min(CCR7), quantile(CCR7_FMO$CCR7, 0.99),
                                           max(CCR7)),labels = c(0, 1)),
           CD69_cut = cut(CD69, breaks = c(min(CD69), quantile(CD69_FMO$CD69, 0.99),
                                           max(CD69)),labels = c(0, 1)),
           CTLA4_cut = cut(CTLA4, breaks = c(min(CTLA4), quantile(CTLA4_FMO$CTLA4, 0.99),
                                             max(CTLA4)),labels = c(0, 1)),
           CD27_cut = cut(CD27, breaks = c(min(CD27), quantile(CD27_FMO$CD27, 0.99),
                                           max(CD27)), labels = c(0, 1)),
           CD153_cut = cut(CD153, breaks = c(min(CD153), quantile(CD153_FMO$CD153, 0.99),
                                             max(CD153)),labels = c(0, 1)),
           KLRG1_cut = cut(KLRG1, breaks = c(min(KLRG1), quantile(KLRG1_FMO$KLRG1, 0.99),
                                             max(KLRG1)), labels = c(0, 1)),
           CXCR1_cut = cut(CXCR1, breaks = c(min(CXCR1), quantile(CXCR1_FMO$CXCR1, 0.99),
                                             max(CXCR1)), labels = c(0, 1)),
           CD122_cut = cut(CD122, breaks = c(min(CD122), quantile(CD122_FMO$CD122, 0.99),
                                             max(CD122)), labels = c(0, 1)),
           PD1_cut = cut(PD1, breaks = c(min(PD1), quantile(PD1_FMO$PD1, 0.99),
                                         max(PD1)), labels = c(0, 1)),
           CD62L_cut = cut(CD62L, breaks = c(min(CD62L), quantile(CD62L_FMO$CD62L, 0.99),
                                             max(CD62L)), labels = c(0, 1)),
           CD45RB_cut = cut(CD45RB, breaks = c(min(CD45RB),
                                               quantile(CD45RB_FMO$CD45RB, 0.99),
                                               max(CD45RB)), labels = c(0, 1)),
           CD28_cut = cut(CD28, breaks = c(min(CD28), quantile(CD28_FMO$CD28, 0.99),
                                           max(CD28)), labels = c(0, 1)),
           CXCR5_cut = cut(CXCR5, breaks = c(min(CXCR5), quantile(CXCR5_FMO$CXCR5, 0.99),
                                             max(CXCR5)), labels = c(0, 1))) %>%
    select(ends_with("cut")) %>%
    mutate_all(funs(replace_na(.,0)))
}


all_kmeans <- function(sample_cut) {
  sample_cut_kmeans <- kmeans(sample_cut, unique(sample_cut))
  sample_cut_kmeans <- cbind(sample_cut_kmeans$size, sample_cut_kmeans$centers) %>%
    data.frame() %>%
    rename("cell_no" = "V1") %>%
    mutate(percentage = format(100*(cell_no / sum(cell_no)), scientific = FALSE))  %>%
    select(cell_no, percentage, CD3_cut: CXCR5_cut) %>%
    print()
}
