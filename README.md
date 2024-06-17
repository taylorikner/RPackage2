
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RPackage2

<!-- badges: start -->

[![Launch Posit
Cloud](https://img.shields.io/badge/launch-posit%20cloud-447099?style=flat)](https://posit.cloud/content/8346360)
<!-- badges: end -->

The goal of `RPackage2` is to provide examples of how to create an R
package. `RPackage2` currently version 0.1.0 last built on 17-June-2024.

It includes functions for addition, multiplication, rolling dice,
flipping coins, as well as some functions we utilized in the class such
as counting missing columns.

It also includes both an
[R6](https://adv-r.hadley.nz/r6.html#r6)`::`[R6Class](https://r6.r-lib.org/articles/Introduction.html)
and [S4](https://adv-r.hadley.nz/s4.html) version of a deck of cards
where we create a deck of cards, shuffling a deck, and drawing cards
from the deck.

## Installation

You can install the development version of RPackage2 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jkylearmstrong/RPackage2")
```

## Example

Here are some basic examples:

``` r
library(RPackage2)
```

### Arithmetic

``` r
addition(1,2)
#> [1] 3
```

``` r
multiplication(5,-4)
#> [1] -20
```

``` r
multiplication(pi, complex(1,0,1)) |>
  exp() |>
  addition(1) # essentially 0, error due to floating point arithmetic
#> [1] 0+1.224647e-16i
```

### Data Analysis

``` r
mtcars |>
  missing_at_random() |>
  features_percent_miss()
#> # A tibble: 11 × 5
#>    feature SumNa SumComp PctNa PctComp
#>    <chr>   <int>   <int> <dbl>   <dbl>
#>  1 gear       14      18 0.438   0.562
#>  2 mpg        11      21 0.344   0.656
#>  3 qsec       11      21 0.344   0.656
#>  4 am         11      21 0.344   0.656
#>  5 carb       11      21 0.344   0.656
#>  6 drat       10      22 0.312   0.688
#>  7 vs         10      22 0.312   0.688
#>  8 hp          8      24 0.25    0.75 
#>  9 cyl         7      25 0.219   0.781
#> 10 disp        6      26 0.188   0.812
#> 11 wt          6      26 0.188   0.812
```

``` r
mtcars |>
  missing_at_random() |>
  features_percent_miss() |>
  plot()
```

<img src="man/figures/README-features_percent_miss_plot-1.png" width="100%" />

``` r
mtcars |>
  missing_at_random() |>
  missmap()
```

<img src="man/figures/README-missmap-1.png" width="100%" />

### Coin and Dice

``` r
# Flip a coin 10 times
coin_flip(10)
#>  [1] "Heads" "Tails" "Tails" "Heads" "Heads" "Tails" "Heads" "Tails" "Tails"
#> [10] "Tails"
```

``` r
# Roll a 3-sided die 10 times
roll_dice(sides = 3, rolls = 10)
#>  [1] 1 1 2 2 1 1 3 2 3 3
```

### Deck of Cards (R6)

``` r
# Create a new deck
my_deck <- DeckOfCards$new()

# Shuffle the deck
my_deck$reshuffle()

# Draw cards
drawn_cards1 <- my_deck$draw(5)

# Print drawn cards
print(my_deck$drawn)
#>     Card     Suit
#> 18     5 Diamonds
#> 3      3   Hearts
#> 17     4 Diamonds
#> 51 Queen   Spades
#> 14   Ace Diamonds
```

``` r

# should be the same
drawn_cards1 == my_deck$drawn
#>    Card Suit
#> 18 TRUE TRUE
#> 3  TRUE TRUE
#> 17 TRUE TRUE
#> 51 TRUE TRUE
#> 14 TRUE TRUE
```

``` r

# Draw more cards
drawn_cards2 <- my_deck$draw(3)

# should be the same
rbind(drawn_cards1, drawn_cards2) == my_deck$drawn
#>    Card Suit
#> 18 TRUE TRUE
#> 3  TRUE TRUE
#> 17 TRUE TRUE
#> 51 TRUE TRUE
#> 14 TRUE TRUE
#> 45 TRUE TRUE
#> 6  TRUE TRUE
#> 20 TRUE TRUE
```

``` r

# Print drawn cards
print(my_deck$drawn)
#>     Card     Suit
#> 18     5 Diamonds
#> 3      3   Hearts
#> 17     4 Diamonds
#> 51 Queen   Spades
#> 14   Ace Diamonds
#> 45     6   Spades
#> 6      6   Hearts
#> 20     7 Diamonds
```

### Deck of Cards (S4)

``` r
# Create a new deck
deck <- new("DeckOfCards4", setofcards = createDeck())

# Shuffle the deck
shuffled_deck <- shuffle(deck)

head(shuffled_deck@setofcards)
#>    Card     Suit
#> 1   Ace   Hearts
#> 36   10    Clubs
#> 31    5    Clubs
#> 16    3 Diamonds
#> 8     8   Hearts
#> 4     4   Hearts
```

``` r

# Draw cards

result <- draw(deck, deck, 5)

# Print drawn cards
result
#> $drawn
#>    Card     Suit
#> 20    7 Diamonds
#> 49   10   Spades
#> 5     5   Hearts
#> 28    2    Clubs
#> 21    8 Diamonds
#> 
#> $object
#> An object of class "DeckOfCards4"
#> Slot "setofcards":
#>     Card     Suit
#> 38 Queen    Clubs
#> 32     6    Clubs
#> 52  King   Spades
#> 39  King    Clubs
#> 6      6   Hearts
#> 36    10    Clubs
#> 2      2   Hearts
#> 44     5   Spades
#> 50  Jack   Spades
#> 3      3   Hearts
#> 27   Ace    Clubs
#> 31     5    Clubs
#> 7      7   Hearts
#> 33     7    Clubs
#> 11  Jack   Hearts
#> 23    10 Diamonds
#> 9      9   Hearts
#> 18     5 Diamonds
#> 1    Ace   Hearts
#> 24  Jack Diamonds
#> 41     2   Spades
#> 45     6   Spades
#> 37  Jack    Clubs
#> 25 Queen Diamonds
#> 17     4 Diamonds
#> 29     3    Clubs
#> 46     7   Spades
#> 13  King   Hearts
#> 16     3 Diamonds
#> 26  King Diamonds
#> 22     9 Diamonds
#> 34     8    Clubs
#> 15     2 Diamonds
#> 10    10   Hearts
#> 14   Ace Diamonds
#> 43     4   Spades
#> 51 Queen   Spades
#> 40   Ace   Spades
#> 4      4   Hearts
#> 48     9   Spades
#> 8      8   Hearts
#> 19     6 Diamonds
#> 35     9    Clubs
#> 12 Queen   Hearts
#> 30     4    Clubs
#> 42     3   Spades
#> 47     8   Spades
```
