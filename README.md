
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RPackage2

<!-- badges: start -->
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
#> [1] 0+1.224606e-16i
```

### Data Analysis

``` r
mtcars |>
  missing_at_random() |>
  features_percent_miss()
#> # A tibble: 11 × 5
#>    feature SumNa SumComp PctNa PctComp
#>    <chr>   <int>   <int> <dbl>   <dbl>
#>  1 disp       14      18 0.438   0.562
#>  2 hp         12      20 0.375   0.625
#>  3 gear       11      21 0.344   0.656
#>  4 mpg        10      22 0.312   0.688
#>  5 qsec       10      22 0.312   0.688
#>  6 am         10      22 0.312   0.688
#>  7 wt          9      23 0.281   0.719
#>  8 carb        9      23 0.281   0.719
#>  9 cyl         8      24 0.25    0.75 
#> 10 drat        8      24 0.25    0.75 
#> 11 vs          7      25 0.219   0.781
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
#>  [1] "Heads" "Heads" "Heads" "Tails" "Tails" "Heads" "Tails" "Tails" "Tails"
#> [10] "Tails"
```

``` r
# Roll a 3-sided die 10 times
roll_dice(sides = 3, rolls = 10)
#>  [1] 2 2 2 3 2 2 3 1 1 2
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
#> 34     8    Clubs
#> 25 Queen Diamonds
#> 7      7   Hearts
#> 23    10 Diamonds
#> 2      2   Hearts
```

``` r

# should be the same
drawn_cards1 == my_deck$drawn
#>    Card Suit
#> 34 TRUE TRUE
#> 25 TRUE TRUE
#> 7  TRUE TRUE
#> 23 TRUE TRUE
#> 2  TRUE TRUE
```

``` r

# Draw more cards
drawn_cards2 <- my_deck$draw(3)

# should be the same
rbind(drawn_cards1, drawn_cards2) == my_deck$drawn
#>    Card Suit
#> 34 TRUE TRUE
#> 25 TRUE TRUE
#> 7  TRUE TRUE
#> 23 TRUE TRUE
#> 2  TRUE TRUE
#> 47 TRUE TRUE
#> 26 TRUE TRUE
#> 9  TRUE TRUE
```

``` r

# Print drawn cards
print(my_deck$drawn)
#>     Card     Suit
#> 34     8    Clubs
#> 25 Queen Diamonds
#> 7      7   Hearts
#> 23    10 Diamonds
#> 2      2   Hearts
#> 47     8   Spades
#> 26  King Diamonds
#> 9      9   Hearts
```

### Deck of Cards (S4)

``` r
# Create a new deck
deck <- new("DeckOfCards4", setofcards = createDeck())

# Shuffle the deck
shuffled_deck <- shuffle(deck)

head(shuffled_deck@setofcards)
#>    Card     Suit
#> 22    9 Diamonds
#> 15    2 Diamonds
#> 17    4 Diamonds
#> 35    9    Clubs
#> 42    3   Spades
#> 7     7   Hearts
```

``` r

# Draw cards

result <- draw(deck, deck, 5)

# Print drawn cards
result
#> $drawn
#>     Card     Suit
#> 26  King Diamonds
#> 32     6    Clubs
#> 25 Queen Diamonds
#> 52  King   Spades
#> 41     2   Spades
#> 
#> $object
#> An object of class "DeckOfCards4"
#> Slot "setofcards":
#>     Card     Suit
#> 17     4 Diamonds
#> 27   Ace    Clubs
#> 8      8   Hearts
#> 1    Ace   Hearts
#> 5      5   Hearts
#> 9      9   Hearts
#> 31     5    Clubs
#> 34     8    Clubs
#> 48     9   Spades
#> 4      4   Hearts
#> 13  King   Hearts
#> 20     7 Diamonds
#> 11  Jack   Hearts
#> 50  Jack   Spades
#> 43     4   Spades
#> 18     5 Diamonds
#> 46     7   Spades
#> 30     4    Clubs
#> 19     6 Diamonds
#> 7      7   Hearts
#> 47     8   Spades
#> 37  Jack    Clubs
#> 44     5   Spades
#> 42     3   Spades
#> 40   Ace   Spades
#> 49    10   Spades
#> 6      6   Hearts
#> 24  Jack Diamonds
#> 38 Queen    Clubs
#> 29     3    Clubs
#> 35     9    Clubs
#> 12 Queen   Hearts
#> 10    10   Hearts
#> 33     7    Clubs
#> 28     2    Clubs
#> 16     3 Diamonds
#> 51 Queen   Spades
#> 2      2   Hearts
#> 14   Ace Diamonds
#> 3      3   Hearts
#> 45     6   Spades
#> 23    10 Diamonds
#> 39  King    Clubs
#> 15     2 Diamonds
#> 22     9 Diamonds
#> 36    10    Clubs
#> 21     8 Diamonds
```
