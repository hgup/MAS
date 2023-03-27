precis( m4.3 )

# impression of magnitude of means
plot( height ~ weight , data=d2 , col=rangi2 )
post <- extract.samples( m4.3 )
a_map <- mean(post$a)
b_map <- mean(post$b)
curve( a_map + b_map*(x - xbar) , add=TRUE )

# adding uncertainity information
post <- extract.samples( m4.3 )
post[ 1:5 , ] 
# correlated random samples from joint posterior of three params using vcov()


# we use only some data to begin with
N <- 80
dN <- d2[ 1:N , ]
mN <- quap(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu <- a + b*(weight - mean(weight) ) ,
    a ~ dnorm( 178 , 20 ) , 
    b ~ dlnorm( 0 , 1 ) , # b's order of magnitude follows norm(1,0)
    sigma ~ dunif( 0 , 50 )
  ) , data=dN
)

# extract 20 samples from the posterior
post <- extract.samples( mN , n=20 )
plot( dN$weight , dN$height ,
      xlim=range(d2$weight) , ylim=range(d2$height) , 
      col=rangi2 , xlab="weight" , ylab="height" )
mtext(concat("N =",N))

# plot the lines, with transparency
for (i in 1:20 )curve( post$a[i] + post$b[i]*(x-mean(dN$weight)) , 
         col=col.alpha("black",0.3) , add=TRUE )


# take the case of 50 kg
post <- extract.samples( m4.3 )
mu_at_50 <- post$a + post$b * ( 50 - xbar )
head(mu_at_50) # using parameters incorporating covariance

dens (mu_at_50 , col=rangi2 , lwd=2 , xlab="mu|weight=50")

PI( mu_at_50 , prob=0.89 )
precis( mu_at_50 )


# do it for every weight value
mu <- link( m4.3 )
str(mu)

# define sequence of weights to compute predictions for
weight.seq <-  seq( from=25 , to=70 , by=1 ) #x-axis

# use link to compute mu
# for each sample from posteror
# for each weight in weight.seq
mu <- link( m4.3 , data=data.frame(weight=weight.seq) )
str(mu)


plot( height ~ weight , d2 , type="n" )

for ( i in 1:100 )
  points( weight.seq , mu[i,] , pch=16 , col=col.alpha(rangi2,0.1) )


# summarize the distribution for each weight value
mu.mean <- apply( mu, 2 , mean )
mu.PI <- apply( mu , 2 , PI , prob=0.89)


# plot the summaries on top of the data

# raw data
# fading to make line and intervals more visible
plot( height ~ weight , data=d2 , col=col.alpha(rangi2,0.5) )

# plot the MAP line, aka the mean mu for each weight
lines( weight.seq , mu.mean )

# rethinking:: plot a shaded region for the 89% PI
shade( mu.PI , weight.seq )

