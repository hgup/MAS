# link without specifying new data -> use original data
mu <- link( m5.3 )

# summarize samples (across cases)
mu_mean <-  apply( mu , 2 , mean )
mu_PI <- apply( mu , 2 , PI )

# simulate observations -> use original data
D_sim <- sim( m5.3 , n=1e4 )
D_PI <- apply( D_sim , 2 , PI )

# plot
plot( mu_mean ~ d$D , col=rangi2 , ylim=range(mu_PI) , 
      xlab="Observed divorce" , ylab="Predicted divorce" )
abline( a=0 , b=1 , lty=2 ) # what would be ideal for this plot?

# lines( x-coords , y-coords )
for ( i in 1:nrow(d) ) lines( rep(d$D[i],2) , mu_PI[,i] , col=rangi2 )

# one helluva function
identify( x=d$D , y=mu_mean , labels=d$Loc)
