#' Missingness Map
#'
#' This function creates a missingness map for a dataframe. The map shows the missingness of each cell in the dataframe.
#'
#' @param df A dataframe
#' @param na_list list of elements to allow SumNa to think of as NA
#' @param row_order logical value to determine if the rows should be ordered by the number of missing values
#'
#' @return A ggplot object
#'
#' @examples
#' data <- data.frame(
#' col1 = c(1, NA, 3, "NA"),
#' col2 = c("A", "B", "C", "D")
#' )
#' missmap(data)
#'
#' mtcars |>
#'   missing_at_random()
#'   missmap()
#'
#'
#' @import dplyr
#' @import ggplot2
#' @importFrom tidyr pivot_longer
#' @importFrom forcats fct_reorder fct
#'
#' @export missmap

missmap <- function(df, na_list = NULL, row_order = FALSE){
  missmat <- df |>
    rowwise() |>
    mutate(across(everything(), SumNa)) |>
    ungroup() |>
    rownames_to_column() |>
    tidyr::pivot_longer(-rowname, names_to = "feature", values_to = "is_na")

  if(row_order == FALSE){
    row_order <- missmat |>
      group_by(rowname) |>
      summarise(rowsum_na =sum(is_na)) |>
      arrange(desc(rowsum_na)) |>
      pull(rowname)

    col_order <- missmat |>
      group_by(feature) |>
      summarise(colsum_na =sum(is_na)) |>
      arrange(desc(colsum_na)) |>
      pull(feature)

    missmat <- missmat |>
      mutate(rowname = forcats::fct_relevel(rowname, row_order)) |>
      mutate(feature = forcats::fct_relevel(feature, col_order))
  } else {
    missmat <- missmat |>
      mutate(rowname = forcats::fct(rowname)) |>
      mutate(feature = forcats::fct(feature))
  }

  missmat |>
    mutate(is_na = if_else(is_na == 0, "Present", "Missing")) |>
    mutate(Missing = forcats::fct_relevel(is_na, "Missing")) |>
    ggplot(aes(x = rowname, y =feature , fill = Missing)) +
    geom_tile() +
    labs(x = "Row", y = "Column", fill = "Missing") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size =6))
}
