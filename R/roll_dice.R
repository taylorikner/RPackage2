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



#' Coin Flip
#'
#' This function simulates flipping a coin.
#'
#' @param flips The number of times to flip the coin.
#' @param coins The number of coins to flip.
#'
#' @return A vector of integers representing the results of the coin flips.
#'
#' @examples
#'
#' coin_flip(1, 1)
#' coin_flip(10, 1)
#' coin_flip(1, 10)
#'
#' @export coin_flip

coin_flip <- function(flips = 1, coins = 1) {
  return(sample(c("Heads", "Tails"), size = flips * coins, replace = TRUE))
}
