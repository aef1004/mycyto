#' @param df the dataframe that contains the filtered FMO (so only the FMO filename has data for the FMO marker)
#'
#'
#' @export
#'
#'
get_99 <- function(df) {

  add_quantile <- df %>%
    group_by(filename) %>%
    summarise(quantile_99 = quantile(MFI, 0.99))

  return(add_quantile)
}
