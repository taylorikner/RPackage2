#' # Create a new deck
#'
#' # draw 40 cards
#' drawn_cards3 <- my_deck$draw(40)
#' # sort the remaining cards
#' my_deck$solitaire("deck") |> print()

my_deck <- DeckOfCards$new()
x <- my_deck$deck

my_deck$reshuffle()

test_that("reshuffle works", {
  expect_equal(all((x == my_deck$deck) == TRUE) , FALSE)
})

my_deck$solitaire("deck")
my_deck$deck


drawn_num1 <- sample(1:10,1)
drawn_num2 <- sample(1:10,1)

# Draw cards
drawn_cards1 <- my_deck$draw(drawn_num1)

test_that("draw works 1", {
  expect_equal(drawn_cards1, my_deck$drawn)
               })

drawn_cards2 <- my_deck$draw(drawn_num2)

# drawn works
test_that("drawn works", {
  expect_equal(rbind(drawn_cards1, drawn_cards2), my_deck$drawn)
})

# Reshuffle the deck
my_deck$reshuffle()

test_that("Reshuffle works", {
  expect_equal(nrow(my_deck$deck), 52)
  expect_equal(nrow(my_deck$drawn), 0)
})

my_deck <- DeckOfCards$new(use_jokers = TRUE)

test_that("jokers works", {
  expect_equal(nrow(my_deck$deck), 52 + 4)
  expect_equal(my_deck$deck |>
                 dplyr::filter(Card == "Joker") |>
                 nrow(), 4)
})




