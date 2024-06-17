# prepare_deck.R
# ---------------
# ################################################
# cards <- c("Ace", 2:10, "Jack", "Queen", "King")
# suits <- c("Hearts", "Diamonds", "Clubs", "Spades")
# jokers <- c("Joker")
#
# jokers <- expand.grid(Card = jokers, Suit = suits, stringsAsFactors = FALSE)
#
# deck <- expand.grid(Card = cards, Suit = suits, stringsAsFactors = FALSE)
# deck <- rbind(deck, jokers)
# deck <- deck |>
#   dplyr::mutate(Card = factor(Card, c("Ace", 2:10, "Jack", "Queen", "King", "Joker"), ordered = TRUE)) |>
#   dplyr::mutate(Suit = factor(Suit, c("Hearts", "Clubs", "Diamonds", "Spades")))
# deck <- deck[sample(nrow(deck)), ]
# usethis::use_data(deck, overwrite = TRUE)


