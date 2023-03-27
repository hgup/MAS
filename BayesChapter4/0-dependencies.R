# source this file before any other
library(rethinking)
library(splines)
data(Howell1)
data(cherry_blossoms)
d <- Howell1

str(d)
precis(d)