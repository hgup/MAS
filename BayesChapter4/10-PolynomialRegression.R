# we use the full kung data d

plot( height ~ weight , d )

# preprocess variable transformations
# prevents recalculation on every iteration of the fitting procedure
d$weight_s <- ( d$weight - mean(d$weight) )/sd(d$weight)
d$weight_s2 <- d$weight_s^2

m4.5 <- quap(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu <- a + b1*weight_s + b2*weight_s2 ,
    a <- dnorm( 178 , 20 ) ,
    b1 <- dlnorm( 0 , 1 ) ,
    b2 <- dnorm( 0 , 1 ) , # allow for negatives too
    sigma ~ dunif( 0 , 50 )
  ) , data=d )


# Doubt: the values of the priors can be anything that's
# reasonably close to the MAP. Here, I used values from previous fit
# but it gave me a different fit. why?
#m4.5 <- quap(
#  alist(
#    height ~ dnorm( mu , sigma ) ,
#    mu <- a + b1*weight_s + b2*weight_s2 ,
#    a <- dnorm( 146.06 , 20  ) ,
#    b1 <- dlnorm( 21.73  , 1   ) ,
#    b2 <- dnorm( -7.80 , 1 ) , # allow for negatives too
#    sigma ~ dunif( 0 , 20 )
#  ) , data=d )

precis( m4.5 )

# interpreting the model fit
weight.seq <- seq( from=-2.2 , to=2 , length.out=30 )
pred_data <- list( weight_s=weight.seq, weight_s2=weight.seq^2 )
mu <- link(m4.5 , data=pred_data )
mu.mean <- apply(mu, 2 , mean )
mu.PI <- apply(mu , 2 , PI , prob=0.89 )
sim.height <- sim( m4.5 , data=pred_data )
height.PI <- apply( sim.height , 2 , PI , prob=0.89 )

# plot em
plot( height ~ weight_s , data=d , col=col.alpha(rangi2, 0.5) , xlab="quadratic" )
lines( weight.seq , mu.mean )
shade( mu.PI , weight.seq )
shade( height.PI , weight.seq )
