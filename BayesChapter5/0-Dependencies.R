library(rethinking)
library(dagitty)
data("WaffleDivorce")
d <- WaffleDivorce #copy

# standardize variables
d$D <- standardize( d$Divorce )
d$M <- standardize( d$Marriage )
d$A <- standardize( d$MedianAgeMarriage )
