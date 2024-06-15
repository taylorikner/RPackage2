#' Plot method for features_percent_miss objects
#'
#' This function creates a bar plot showing the percentage of complete values
#' for each feature in a data frame or tibble.
#'
#' @param x An object of class 'features_percent_miss' returned by the
#'   \code{\link{features_percent_miss}} function.
#' @param add.label logical add percent labels to graph, defaults to TRUE
#'
#' @return A ggplot object representing the bar plot.
#'
#' @examples
#' data(input_parameters_raw)
#' 
#' input_parameters_raw |>
#'   features_percent_miss(na_list = c(""," ","NA")) |>
#'   plot()
#'
#' @import dplyr ggplot2 scales
#' @importFrom stats reorder
#'
#' @export
#' @rdname features_percent_miss

plot.features_percent_miss <- function(x, add.label = TRUE){
  if(add.label){
    plot_obj <- x %>%
      mutate(feature = reorder(feature, desc(PctNa))) %>%
      ggplot2::ggplot(aes(x=PctNa, y =feature , fill = PctNa)) +
      geom_bar(stat = "identity") +
      geom_label(aes(label = paste0(round(PctNa*100,2)," %"))) +
      scale_fill_gradient(low="green", high="red", limits=c(0,1)) +
      scale_x_continuous(labels=percent_format(scale=100), limits=c(0,1)) +
      labs(x= "Percent Missing", y= "Column", title = "Missing Data Plot") +
      theme(legend.position = "none")
  } else{
    plot_obj <- x %>%
      mutate(feature = reorder(feature, desc(PctNa))) %>%
      ggplot2::ggplot(aes(x=PctNa, y =feature , fill = PctNa)) +
      geom_bar(stat = "identity") +
      #geom_label(aes(label = paste0(round(PctNa*100,2)," %"))) +
      scale_fill_gradient(low="green", high="red", limits=c(0,1)) +
      scale_x_continuous(labels=percent_format(scale=100), limits=c(0,1)) +
      labs(x= "Percent Missing", y= "Column", title = "Missing Data Plot") +
      theme(legend.position = "none")
  }
  
  return(plot_obj)
}
