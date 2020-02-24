#' @param flowSet the flowset in which to convert to a tidy flow set

#' Create a function that applies this to all items in a 'flowSet' object
#' This function calles tidy_flow_tiem
#' @export
tidy_flow_set <- function(flowSet){
  flow_set <- flowCore::fsApply(x = flowSet,
                                FUN = tidy_flow_item)
  flow_set <- dplyr::bind_rows(flow_set, .id = "filename")
}
