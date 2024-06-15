#' Deck of Cards
#'
#' This R6 class simulates a deck of cards that allows drawing and reshuffling.
#'
#' @title DeckOfCards
#'
#' @description This R6 class simulates a deck of cards that allows drawing and reshuffling.
#'
#' @import R6
#'
#' @export DeckOfCards
#'
#' @examples
#' # Create a new deck
#' my_deck <- DeckOfCards$new()
#' # Shuffle the deck
#' my_deck$reshuffle()
#' # Draw cards
#' drawn_cards1 <- my_deck$draw(5)
#' # Print drawn cards
#' print(my_deck$drawn)
#' should be the same
#' drawn_cards1 == my_deck$drawn
#' # Draw more cards
#' drawn_cards2 <- my_deck$draw(3)
#' should be the same
#' rbind(drawn_cards1, drawn_cards2) == my_deck$drawn
#' # Print drawn cards
#' print(my_deck$drawn)
#' # Check number of cards
#'nrow(rbind(drawn_cards1, drawn_cards2)) + nrow(my_deck$deck) == 52
#' # Reshuffle the deck
#' my_deck$reshuffle()
#' nrow(my_deck$deck) == 52
#' nrow(my_deck$drawn) == 0
#' # draw 40 cards
#' drawn_cards3 <- my_deck$draw(40)
#' # sort the remaining cards
#' my_deck$solitaire("deck")
#'

DeckOfCards <- R6::R6Class("DeckOfCards",
                       public = list(
                         #'
                         #' @field deck
                         #' A data frame representing the deck of cards.
                         deck = NULL,

                         #' @field drawn
                         #' A data frame representing the drawn cards.
                         drawn = NULL,

                         #' @description
                         #' Initialize the deck of cards.
                         #'
                         #' @return a data frame representing the deck of cards.

                         initialize  = function() {
                           cards <- c("Ace", 2:10, "Jack", "Queen", "King")
                           suits <- c("Hearts", "Diamonds", "Clubs", "Spades") # c("♠", "♥", "♦", "♣")
                           deck <- expand.grid(Card = cards, Suit = suits)
                           deck <- deck[sample(1:nrow(deck)), ]
                           self$deck <- deck
                           self$drawn <- data.frame()
                         },

                         #' @description
                         #' Draw a specified number of cards from the deck.
                         #'
                         #' @param draws The number of cards to draw from the deck.
                         #' @return A data frame representing the drawn cards.

                         draw = function(draws = 1) {
                           if (nrow(self$deck) < draws) {
                             stop("Not enough cards left in the deck to draw the requested number of cards.")
                           }

                           drawn_cards <- self$deck[sample(nrow(self$deck), draws), ]
                           self$deck <- self$deck[!rownames(self$deck) %in% rownames(drawn_cards), ]
                           self$drawn <- rbind(self$drawn, drawn_cards)
                           return(drawn_cards)
                         },

                         #' @description
                         #' Reshuffle the deck of cards.
                         #'
                         #' @return a data frame representing the reshuffled deck of cards.

                         reshuffle = function() {
                           self$deck <- rbind(self$deck, self$drawn)
                           self$deck <- self$deck[sample(nrow(self$deck)), ]
                           self$drawn <- data.frame()
                         }

                         #' @description
                         #' sort the deck of cards.
                         #' @param hand_type
                         #' either the `deck` or the `drawn` hand.
                         #' @return a data frame representing the sorted deck of cards.

                         solitaire = function(hand_type = 'deck') {
                           if (hand_type != "deck" && hand_type != "drawn") {
                             stop("Invalid hand type. Please specify 'deck' or 'drawn'.")
                           }

                           hand <- if (hand_type == "deck") self$deck else self$drawn
                           hand <- hand[order(hand$Suit, hand$Card), ]

                           if (hand_type == "deck") {
                             self$deck <- hand
                           } else {
                             self$drawn <- hand
                           }
                         }
                       )
)


#' Boot of Decks
#'
#' This R6 class simulates a boot of decks that allows drawing and reshuffling.
#'
#' @name BootOfDecks
#'
#' @import R6
#'
#' @examples
#' drawn_cards1 <- my_boot$draw(5)
#' # Print drawn cards
#' print(drawn_cards)
#' # should be the same
#' drawn_cards1 == my_boot$drawn
#' # Draw more cards
#' drawn_cards2 <- my_boot$draw(5)
#' # should be the same
#' bind_rows(drawn_cards1,drawn_cards2) == my_boot$drawn
#' # Print remaining cards
#' print(my_boot$deck)
#' # Reshuffle the boot
#' my_boot$reshuffle()
#' should be empty
#' print(my_boot$drawn)
#'
#'
#' @export BootOfDecks
BootOfDecks <- R6::R6Class("BootOfDecks",
                       public = list(
                         #' @field decks
                         #' A list of DeckOfCards objects.
                         deck = data.frame(),

                         #' @field drawn
                         #' A data frame representing the drawn cards.
                         drawn = data.frame(),

                         #' @description
                         #' Initialize the boot of decks.
                         #'
                         #' @param number_of_decks The number of decks in the boot.
                         #' @return A list of DeckOfCards objects.

                         initialize = function(number_of_decks) {
                           for (i in 1:number_of_decks) {
                             self$deck <- DeckOfCards$new()$deck
                           }
                         },

                         #' @description
                         #' Reshuffle the boot of decks.
                         #'
                         #' @return A data frame representing the reshuffled boot of decks.

                         reshuffle = function() {
                           self$deck <- rbind(self$deck, self$drawn)
                           self$deck <- self$deck[sample(nrow(self$deck)), ]
                           self$drawn <- data.frame()
                         },

                         #' @description
                         #' Draw a specified number of cards from the boot.
                         #'
                         #' @param draws The number of cards to draw from the boot.
                         #' @return A data frame representing the drawn cards.

                         draw = function(draws = 1) {
                           if (nrow(self$deck) < draws) {
                             stop("Not enough cards left to draw the requested number of cards.")
                           }
                           drawn_cards <- self$deck[sample(nrow(self$deck), draws), ]
                           self$deck <- self$deck[!rownames(self$deck) %in% rownames(drawn_cards), ]
                           self$drawn <-  rbind(self$drawn, drawn_cards)
                           return(drawn_cards)
                         }

                         #' @description
                         #' sort the deck of cards.
                         #' @param hand_type
                         #' either the `deck` or the `drawn` hand.
                         #' @return a data frame representing the sorted deck of cards.

                         solitaire = function(hand_type = 'deck') {
                           if (hand_type != "deck" && hand_type != "drawn") {
                             stop("Invalid hand type. Please specify 'deck' or 'drawn'.")
                           }

                           hand <- if (hand_type == "deck") self$deck else self$drawn
                           hand <- hand[order(hand$Suit, hand$Card), ]

                           if (hand_type == "deck") {
                             self$deck <- hand
                           } else {
                             self$drawn <- hand
                           }
                         }
                       )
)

#' Draw cards from a deck
#'
#' @description
#' This function draws a specified number of cards from a deck.
#'
#' @param deck The deck object (either DeckOfCards or BootOfDecks).
#' @param draws The number of cards to draw.
#' @return A data frame representing the drawn cards.
#' @examples
#' my_deck <- DeckOfCards$new()
#' my_deck$draw(5)
#' my_boot <- BootOfDecks$new(2)
#' my_boot$draw(5)
#'
#' @export draw_cards
draw_cards <- function(deck, draws = 1, hand = "deck") {
  # Validate the 'hand' parameter
  if (!hand %in% c("deck", "drawn")) {
    stop("Invalid hand type. Please specify 'deck' or 'drawn'.")
  }

  # Select the appropriate hand
  selected_hand <- if (hand == "deck") deck$deck else deck$drawn

  if (nrow(selected_hand) < draws) {
    stop("Not enough cards left in the ", hand, " to draw the requested number of cards.")
  }

  drawn_cards <- selected_hand[sample(nrow(selected_hand), draws), ]

  # Update the appropriate hand
  if (hand == "deck") {
    deck$deck <- deck$deck[!rownames(deck$deck) %in% rownames(drawn_cards), ]
    deck$drawn <- rbind(deck$drawn, drawn_cards)
  } else {
    deck$drawn <- deck$drawn[!rownames(deck$drawn) %in% rownames(drawn_cards), ]
  }

  return(drawn_cards)
}
