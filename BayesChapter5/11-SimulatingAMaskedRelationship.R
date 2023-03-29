n <- 100
# DAGS------------------------------------------

# M -> K <- N
# M -> N
M <- rnorm( n ) # M isn't influenced by any
N <- rnorm( n , M ) # M -> N
K <- rnorm( n , N - M ) # why?
d_sim <- data.frame(K=K,N=N,M=M)

# M -> K <- N
# N -> M
N <- rnorm( n ) # M isn't influenced by any
M <- rnorm( n , N ) # N -> M
K <- rnorm( n , M - N ) # why?
d_sim <- data.frame(K=K,N=N,M=M)

# M -> K <- N
# M <- U -> N
U <- rnorm(n)
N <- rnorm( n , U )
M <- rnorm( n , U )
K <- rnorm( n , N - M )
d_sim <- data.frame(K=K,N=N,M=M)

# models----------------------------------------
m5.5<- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN * N , 
    a ~ dnorm( 0 , 0.2 ) ,
    bN ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d_sim
)

m5.6<- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M , 
    a ~ dnorm( 0 , 0.2 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d_sim
)

m5.7 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN*N + bM*M , 
    a ~ dnorm( 0 , 0.2 ) ,
    bN ~ dnorm( 0 , 0.5 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d_sim
)

# Observing the masking pattern----------------
plot( coeftab( m5.5 , m5.6 , m5.7 ) , pars=c("bM","bN") )
# same masking pattern: coefficients become extreme in m5.7

# Compute the Markov Equivalence set

dag5.7 <- dagitty( "dag{
                   M -> K <- N
                   M -> N }" )
coordinates(dag5.7) <- list( x=c(M=0,K=1,N=2) , y=c(M=0.5,K=1,N=0.5) )
MElist <- equivalentDAGs(dag5.7)

drawdag(MElist)
