#' taken from https://gist.github.com/kdauria/524eade46135f6348140
#'
#' - `stat_smooth_func`: modified from <https://gist.github.com/kdauria/524eade46135f6348140> pull out $r^2$
#' for correlation plots [Amy, For this and the previous function, do you think it would be easier for us to
#' create these modified versions by adding a `geom_text` or `geom_label` line to a ggplot object, instead,
#' rather than changing the geoms for the smooth functions?]


#'
#' @export
#'
#'
stat_smooth_func <- function(mapping = NULL, data = NULL,
                             geom = "smooth", position = "identity",
                             ...,
                             method = "auto",
                             formula = y ~ x,
                             se = TRUE,
                             n = 80,
                             span = 0.75,
                             fullrange = FALSE,
                             level = 0.95,
                             method.args = list(),
                             na.rm = FALSE,
                             show.legend = NA,
                             inherit.aes = TRUE,
                             xpos = NULL,
                             ypos = NULL) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatSmoothFunc,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      method = method,
      formula = formula,
      se = se,
      n = n,
      fullrange = fullrange,
      level = level,
      na.rm = na.rm,
      method.args = method.args,
      span = span,
      xpos = xpos,
      ypos = ypos,
      ...
    )
  )
}
