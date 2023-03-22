library(rethinking)

#W <- 6
#L <- 3
#W <- 12
#L <- 6
W <- 24
L <- 12

#quap -> Quadratic Approximation
globe.qa <- quap(
  alist(
    W ~ dbinom( W+L , p ) , # FORMULA
    p ~ dunif(0,1)
  ) ,
  data=list( W=W , L=L ) # LIST OF DATA (n=9)
)

# W and L in list(...) have to be of same length since, we are using W+L in alist

summ <- precis( globe.qa )


# ANALYTICAL CALCULATION
# analytical posterior
curve( dbeta( x , W+1 , L+1 ) , from=0 , to=1 )

# quadratic approximation
qmean <- as.numeric(summ["mean"])
qsd <- as.numeric(summ["sd"])

curve( dnorm( x , qmean , qsd ) , lty=2 , add=TRUE) #dotted
# plug the mean and std from output of line 14