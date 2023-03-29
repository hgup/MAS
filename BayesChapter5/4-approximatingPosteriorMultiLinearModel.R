m5.3 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M + bA * A , 
    a ~ dnorm( 0 , 0.2 ) , 
    bM ~ dnorm( 0 , 0.5 ) , 
    bA ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp(1)
  ) , data=d
)
precis( m5.3 )
# bM -> very close to zero

# visualize posterior distribution for all models
# focus on bA and bM
# rethinking::coeftab
plot( coeftab(m5.1,m5.2,m5.3) , par=c("bA","bM") )
