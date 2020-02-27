#' Convert flowframe to tidy dataframe
#'
#' @param flowSet the flowset in which to convert to a tidy flow set

# Create a function that applies this to all items in a 'flowSet' object
#' this function is called by tidy_flow_set
#'
#'
library(tibble)
tidy_flow_item <- function(flowSet_item){
  flowSet_item %>%
    Biobase::exprs() %>%
    tibble::as_tibble()
}
