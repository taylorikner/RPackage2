#' Roll a dice
#'
#' This function simulates rolling a dice.
#'
#' @param sides The number of sides on the dice.
#' @param rolls The number of times to roll the dice.
#'
#' @return A vector of integers representing the results of the dice rolls.
#'
#' @examples
#' roll_dice(6, 1)
#' roll_dice(6, 10)
#' roll_dice(20, 1)
#'
#' @export roll_dice

roll_dice <- function(sides =6, rolls = 1) {
  return(sample(1:sides, size = rolls, replace = TRUE))
}
