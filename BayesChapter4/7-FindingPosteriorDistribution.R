d2 <- d[ d$age >= 18 , ]
xbar <- mean(d2$weight) # define average weight

# defining model
flist <- alist( 
  height ~ dnorm( mu , sigma ) , 
  mu ~ a + b*( weight - xbar ) , # or weight - mean(weight)
  a ~ dnorm( 178 , 20 ) , 
  b ~ dlnorm( 0 , 1 ) , 
  sigma ~ dunif( 0 , 50 ) 
)

m4.3 <- quap( flist , data=d2 )

# alternatively using log_b ~ dnorm( 0 , 1 )
#m4.3 <- quap( 
#  alist( 
#    height ~ dnorm( mu , sigma ) , 
#    mu ~ a + exp(log_b)*( weight - xbar ) , 
#    a ~ dnorm( 178 , 20 ) , 
#    log_b ~ dnorm( 0 , 1 ) , 
#    sigma ~ dunif( 0 , 50 ) 
#  ), data=d2 )

