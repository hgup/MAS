
sd( d$MedianAgeMarriage )

# Divorce ~ MedianAgeMarriage
m5.1 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bA * A , 
    a ~ dnorm( 0 , 0.2 ) ,  # try sd = 0.1 or 1
    bA ~ dnorm( 0 , 0.5 ) , # try sd = 0.1 or 1
    sigma ~ dexp( 1 )
  ) , data= d # d contains D,A
)

# simulate priors
set.seed(10)
prior <- extract.prior( m5.1 )
mu <- link( m5.1 , post=prior , data=list( A=c(-2,2) ) )
plot( NULL , xlim=c(-2,2) , ylim=c(-2,2) ,
    xlab="Median age marriage (std)" , ylab="Divorce rate (std)" )
for ( i in 1:50 ) lines( c(-2,2) , mu[i,] , col=col.alpha("black",0.4) )

# Posterior Predictions

# percentile interval of mean
A_seq <- seq( from=-3 , to=3.2 , length.out=30 )
mu <- link( m5.1 , data=list(A=A_seq) )
mu.mean <- apply( mu , 2 , mean )
mu.PI <- apply( mu , 2 , PI )

# plot it all
plot( D ~ A , data=d , col=rangi2 , xlab="Median Age at Marriage", ylab="Divorce rate" )
lines( A_seq , mu.mean , lwd=2 )
shade( mu.PI , A_seq )

precis( m5.1 )
# reliably negative bA

# Divorce ~ Marriage
m5.2 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M , 
    a ~ dnorm( 0 , 0.2 ) ,  # try sd = 0.1 or 1
    bM ~ dnorm( 0 , 0.5 ) , # try sd = 0.1 or 1
    sigma ~ dexp( 1 )
  ) , data= d # d contains D,M
)

# percentile interval of this mean
M_seq <- seq( from=-3 , to=3.2 , length.out=30 )
mu <- link( m5.2 , data=list(M=M_seq) )
mu.mean <- apply( mu , 2 , mean )
mu.PI <- apply( mu , 2 , PI )

# plot it all
plot( D ~ M , data=d , col=rangi2 , xlab="Marriage rate", ylab="Divorce rate" )
lines( A_seq , mu.mean , lwd=2 )
shade( mu.PI , A_seq )

precis(m5.2)
