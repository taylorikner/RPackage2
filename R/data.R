#' Standard Deck of Cards
#'
#' A standard deck of cards including jokers, stored internally for use in package functions.
#'
#' @format A data frame with 54 rows and 3 variables:
#' \describe{
#'   \item{Card}{The card rank, ranging from Ace to King, including Joker.}
#'   \item{Suit}{The card suit: Hearts, Diamonds, Clubs, Spades.}
#' }
#' @source Generated using a script in the 'data-raw/prepare_deck.R'
#' @examples
#' # To access the 'deck' data set within the package:
#'   data("deck", package = "RPackage2")
#'   # now deck is available for use in the function
#'   head(deck)
#'
"deck"
