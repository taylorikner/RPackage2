#' @title Missing data at random
#'
#' @description This function will randomly assign missing values to a dataset
#'
#' @param data A dataset
#' @param prob The probability of a missing value being assigned to a cell
#'
#' @return A dataset with missing values randomly assigned with the given probability
#'
#' @importFrom stats runif
#'
#' @examples
#' mtcars_miss_at_random <- missing_at_random(mtcars)
#'
#' @export missing_at_random

missing_at_random <- function(data, prob= runif(1,1/5,1/3)) {
  for (i in 1:nrow(data)) {
    for (j in 1:ncol(data)) {
      if (runif(1) < prob) {
        data[i, j] <- NA
      }
    }
  }
  return(data)
}


