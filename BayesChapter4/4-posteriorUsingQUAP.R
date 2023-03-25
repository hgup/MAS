# we have 
d2 <- d[ d$age >= 18 ,]

# define model using R formula syntax
flist <- alist(
  height ~ dnorm( mu , sigma ) , 
  mu ~ dnorm( 178 , 20 ) , 
  sigma ~ dunif( 0 , 50 )
)

# fit model to data in d2
m4.1 <- quap( flist , data=d2 )

# creates fit model
precis( m4.1 )
