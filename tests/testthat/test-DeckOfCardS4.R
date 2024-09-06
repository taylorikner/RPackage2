# Test for SetOfCards class
test_that("SetOfCards class is correctly defined", {
  set <- new("SetOfCards")
  expect_s3_class(set@setofcards, "data.frame")
  expect_equal(nrow(set@setofcards), 0)
})

# Test for DeckOfCards4 class
test_that("DeckOfCards4 class is correctly defined", {
  deck <- new("DeckOfCards4")
  expect_s3_class(deck@setofcards, "data.frame")
  expect_equal(nrow(deck@setofcards), 0)
})

# Test for createDeck function
test_that("createDeck function works correctly", {
  deck <- createDeck()
  expect_equal(nrow(deck), 52)
  expect_equal(length(unique(deck$Card)), 13)
  expect_equal(length(unique(deck$Suit)), 4)
})

# Test for shuffle method
test_that("shuffle method works correctly", {
  deck <- new("DeckOfCards4", setofcards = createDeck())
  shuffled_deck <- shuffle(deck)
  expect_false(identical(deck@setofcards, shuffled_deck@setofcards))
})

# Test for draw method
test_that("draw method works correctly", {
  deck <- new("DeckOfCards4", setofcards = createDeck())
  result <- draw(deck, deck, 5)
  expect_equal(nrow(result$drawn), 5)
  expect_equal(nrow(result$object@setofcards), 47)
})

# Test for solitaire method
test_that("solitaire method works correctly", {
  deck <- new("DeckOfCards4", setofcards = createDeck())
  sorted_deck <- solitaire(deck)
  expect_equal(sorted_deck@setofcards, deck@setofcards[order(deck@setofcards$Suit, deck@setofcards$Card), ])
})
