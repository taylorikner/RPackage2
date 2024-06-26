% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/roll_dice.R
\name{roll_dice}
\alias{roll_dice}
\title{Roll a dice}
\usage{
roll_dice(sides = 6, rolls = 1)
}
\arguments{
\item{sides}{The number of sides on the dice.}

\item{rolls}{The number of times to roll the dice.}
}
\value{
A vector of integers representing the results of the dice rolls.
}
\description{
This function simulates rolling a dice.
}
\examples{
roll_dice(6, 1)
roll_dice(6, 10)
roll_dice(20, 1)

}
