#' Set of Cards Class
#'
#' A class representing a set of playing cards.
#'
#' @import methods
#'
#' @slot setofcards A data frame containing a data frame of a set of cards and their suits.
#' @name SetOfCards
#' @export
setClass(
  "SetOfCards",
  slots = c(
    setofcards = "data.frame"
  ),
  prototype = list(
    setofcards = data.frame(Card = character(), Suit = character(), InPlay = logical(), stringsAsFactors = FALSE)
  )
)

#' Deck of Cards Class
#'
#' A class inheriting from SetOfCards, representing a standard deck of playing cards.
#'
#' @slot setofcards A data frame containing a deck of cards and their suits.
#' @name DeckOfCards4
#' @export
setClass(
  "DeckOfCards4",
  contains = "SetOfCards"
)

#' Boot of Decks Class
#'
#' A class representing a collection (boot) of multiple decks of cards.
#'
#' @slot decks A SetOfCards object.
#' @name BootOfDecks4
#' @export
setClass(
  "BootOfDecks4",
  contains = "SetOfCards"
)

#' Player Hand Class
#'
#' A class representing a player's hand of cards.
#'
#' @slot name A character string representing the player's name.
#' @slot hand A SetOfCards object representing the player's hand.
#' @name PlayerHand4
#' @export
setClass(
  "PlayerHand4",
  contains = "SetOfCards",
  slots = c(
    name = "character",
    hand = "SetOfCards"
  ),
  prototype = list(
    name = character(0),
    hand = new("SetOfCards")
  )
)

#' Discard S4 Pile Class
#'
#' A class representing the pile of cards that have been discarded.
#'
#' @slot discard A SetOfCards object representing the discarded cards.
#' @name DiscardPile4
#' @export
setClass(
  "DiscardPile4",
  contains = "SetOfCards",
  slots = c(
    drawn = "SetOfCards"
  ),
  prototype = list(
    drawn = new("SetOfCards")
  )
)

#' Function to create a standard deck dataframe.
#'
#' @param use_jokers A logical value indicating whether to include jokers in the deck.
#'
#' @return A data frame representing a standard deck of playing cards.
#' @name createDeck
#' @export
#' @examples
#' createDeck()
createDeck <- function(use_jokers = FALSE) {
  data("deck", package = "RPackage2")

  if (use_jokers == TRUE) {
    deck <- deck
  } else {
    deck <- deck[deck$Card != "Joker", ]
  }

  set.seed(Sys.time())

  deck <- deck[sample(1:nrow(deck)), ]
  return(deck)
}

#' Function to create a Boot of S4 DeckOfCards4.
#'
#' @param use_jokers A logical value indicating whether to include jokers in the deck.
#'
#' @return A data frame representing a standard deck of playing cards.
#' @name createBootDeck
#' @export
#' @examples
#' createBootDeck()
createBootDeck <- function(num_decks = 2, use_jokers = FALSE) {
  for(i in 1:num_decks){
    deck <- createDeck(use_jokers)
    if(i == 1){
      boot <- deck
    } else {
      boot <- rbind(boot, deck)
    }
  }
  return(boot)
}


#' Shuffle a Set of Cards
#'
#' Randomly permutes the cards in the set.
#'
#' @param object A SetOfCards object.
#' @return The shuffled SetOfCards object.
#' @name shuffle
#' @export
#' @examples
#' my_deck <- new("DeckOfCards4", setofcards = createDeck())
#' my_deck <- shuffle(my_deck)
setGeneric("shuffle", function(object) standardGeneric("shuffle"))

setMethod(
  "shuffle",
  signature = "SetOfCards",
  definition = function(object) {
    set.seed(Sys.time())
    object@setofcards <- object@setofcards[sample(nrow(object@setofcards)), ]
    return(invisible(object))
  }
)

#' Draw Cards from a Set
#'
#' Draws a specified number of cards from the set.
#' @param drawer A PlayerHand4 object or a SetOfCards object.
#' @param draw_from A SetOfCards object or another players hand.
#' @param number The number of cards to draw.
#' @return A list containing the drawn cards and the updated SetOfCards object.
#' @name draw
#' @export
#' @examples
#' my_deck <- new("DeckOfCards4", setofcards = createDeck())
#' result <- draw(my_deck, 5)
#' drawn_cards <- result$drawn
#' drawn_cards
#' my_deck <- result$object
#' my_deck
#' nrow(my_deck) + nrow(drawn_cards)
setGeneric("draw", function(drawer, draw_from, number) standardGeneric("draw"))

setMethod(
  "draw",
  signature = c("SetOfCards", "SetOfCards", "numeric"),
  definition = function(drawer, draw_from, number) {
    if (nrow(draw_from@setofcards) < number) {
      stop("Not enough cards in the set to draw the requested number of cards.")
    }
    drawn_cards <- draw_from@setofcards[1:number, ]
    draw_from@setofcards <- draw_from@setofcards[-(1:number), ]
    return(list(drawn = drawn_cards, object = draw_from))
  }
)

#' Sort a Set of Cards in Solitaire Order
#'
#' Sorts the cards in the set by suit and rank in a specific order.
#'
#' @param object A SetOfCards object.
#' @return The SetOfCards object sorted in solitaire order.
#' @name solitaire
#' @export
#' @examples
#' my_deck <- new("DeckOfCards4", setofcards = createDeck())
#' my_deck_sorted <- solitaire(my_deck)
#' my_deck_sorted
setGeneric("solitaire", function(object) standardGeneric("solitaire"))

setMethod(
  "solitaire",
  signature = "SetOfCards",
  definition = function(object) {
    object@setofcards <- object@setofcards[order(object@setofcards$Suit, object@setofcards$Card), ]
    return(invisible(object))
  }
)

