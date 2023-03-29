# Overthinking: Simulating the divorce example----
set.seed(32)

N <- 50
age <- rnorm( N )
mar <- rnorm( N , -age )
div <- rnorm( N , age )

dat <- data.frame( D=div , M=mar , A=age )


# fit models:
m5.1 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bA * A , # only A
    a ~ dnorm( 0 , 0.2 ) ,  
    bA ~ dnorm( 0 , 0.5 ) , 
    sigma ~ dexp( 1 )
  ) , data= dat # d contains D,A
)

m5.2 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M , # only M
    a ~ dnorm( 0 , 0.2 ) ,  
    bM ~ dnorm( 0 , 0.5 ) , 
    sigma ~ dexp( 1 )
  ) , data= dat # d contains D,M
)

m5.3 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M + bA * A ,  # both A and M
    a ~ dnorm( 0 , 0.2 ) , 
    bM ~ dnorm( 0 , 0.5 ) , 
    bA ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp(1)
  ) , data=dat
)

# investigation
plot( coeftab(m5.1,m5.2,m5.3) , par=c("bA","bM") )
