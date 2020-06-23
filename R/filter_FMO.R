#' @param clean_FMO the dataframe that contains the FMO samples and expression levels, note that here the filename and the column marker names need to match exactly
#'
#'
#' @export
#'
filter_FMO <- function(clean_FMO) {

  testing <- clean_FMO %>%
    gather(key = "marker", value = "MFI", -filename, -`SSC-A`,)

  right <- testing %>%
    filter(str_detect(testing$filename, fixed(testing$marker)) &
             str_detect(testing$marker, fixed(testing$filename)))

  return(right)

}
