
data("milk")
d <- milk

str(d)
# vars: kcal.per.g : kilocalories of energy per gram of milk
# mass : average female body mass in kg
# neocortex.perc percent of total brain mass thatis neocortex mass

d$K <- standardize( d$kcal.per.g )
d$N <- standardize( d$neocortex.perc )
d$M <- standardize( log(d$mass ) )
# exec line 28

# handle missing data----
# K ~ N
m5.5_draft <- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN * N , 
    a ~ dnorm( 0 , 1 ) ,
    bN ~ dnorm( 0 , 1 ) ,
    sigma ~ dexp( 1 )
  ) , data=d
)
# this gives you an error

# drop the missing variables: d complete cases
dcc <- d[ complete.cases(d$K,d$N,d$M) , ]

m5.5_draft <- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN * N , 
    a ~ dnorm( 0 , 1 ) ,
    bN ~ dnorm( 0 , 1 ) ,
    sigma ~ dexp( 1 )
  ) , data=dcc
)

# ensure that priors are reasonable----
prior <- extract.prior( m5.5_draft ) # 1000 values for a,bN,sigma
xseq <- c(-2,2)
mu <- link( m5.5_draft , post=prior , data=list(N=xseq) ) #what does post= do?

plot( NULL , xlim=xseq , ylim=xseq )
for ( i in 1:50 ) lines( xseq , mu[i,] , col=col.alpha("black",0.3) )
# these priors produce crazy lines

# thus
m5.5<- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN * N , 
    a ~ dnorm( 0 , 0.2 ) ,
    bN ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=dcc
)

# ensure that priors are reasonable----
prior <- extract.prior( m5.5 ) # 1000 values for a,bN,sigma
xseq <- c(-2,2)
mu <- link( m5.5 , post=prior , data=list(N=xseq) ) #what does post= do?

plot( NULL , xlim=xseq , ylim=xseq )
for ( i in 1:50 ) lines( xseq , mu[i,] , col=col.alpha("black",0.3) )
# these priors produce crazy lines

# analysing it like humans (not golems)
xseq <- seq( from=min(dcc$N)-0.15 , to=max(dcc$N)+0.15 , length.out=30 )
mu <- link( m5.5 , data=list(N=xseq) )
mu_mean <- apply( mu , 2 , mean )
mu_PI <- apply( mu , 2 , PI )
plot( K ~ N , data=dcc )

lines( xseq , mu_mean , lwd=2 )
shade( mu_PI , xseq )


# check the association of K with female body mass----
# recall that d$M <- standardize( log(d$mass ) )

m5.6<- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bM * M , 
    a ~ dnorm( 0 , 0.2 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=dcc
)
precis( m5.6 )

# check the mean relation using plot
# link
xseq <- seq( from=min(dcc$M)-0.15 , to=max(dcc$M)+0.15 , length.out=30 )
mu <- link( m5.6 , data=list(M=xseq) )
# estimators
mu_mean <- apply( mu , 2 , mean )
mu_PI <- apply( mu , 2 , PI )

plot( K ~ M , data=dcc )
lines( xseq , mu_mean , lwd=2 )
shade( mu_PI , xseq , col=col.alpha("#548d6e") )

# what if we add both M and N ----

m5.7 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a + bN*N + bM*M , 
    a ~ dnorm( 0 , 0.2 ) ,
    bN ~ dnorm( 0 , 0.5 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=dcc
)
precis(m5.7)

plot( coeftab( m5.5 , m5.6 , m5.7 ) , pars=c("bM","bN") )
# bM became more negative and bN became more positive

pairs( ~K + M + N , dcc )

# unobserved predictor U. Remove its influence using Counterfactual plots----

# K ~ N
xseq <- seq( from=min(dcc$N)-0.15 , to=max(dcc$N)+0.15 , length.out=30 )
mu <- link( m5.7 , data=data.frame( N=xseq , M=0 ) )
mu_mean <- apply( mu , 2 , mean )
mu_PI <- apply( mu , 2 , PI )
plot( NULL , xlim=range(dcc$M) , ylim=range(dcc$K) , 
      xlab="neocortex percent (std)" , ylab="kilocal per g (std)")
lines( xseq , mu_mean , lwd=2 )
shade( mu_PI , xseq )

# K ~ M
xseq <- seq( from=min(dcc$M)-0.15 , to=max(dcc$M)+0.15 , length.out=30 )
mu <- link( m5.7 , data=data.frame( M=xseq , N=0 ) )
mu_mean <- apply( mu , 2 , mean )
mu_PI <- apply( mu , 2 , PI )
plot( NULL , xlim=range(dcc$M) , ylim=range(dcc$K) , 
      xlab="log body mass (std)" , ylab="kilocal per g (std)")
lines( xseq , mu_mean , lwd=2 )
shade( mu_PI , xseq )
