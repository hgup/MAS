
plot( d2$height ~ d2$weight )

set.seed(2971) # reproduce book's exact output
N <- 100
a <- rnorm( N , 178 , 20 )
b <- rnorm( N , 0 , 10 )
# 100 pairs of \alpha and \beta

plot( NULL , xlim=range(d2$weight) , ylim=c(-100,400) , 
      xlab="weight" , ylab="height" )

# add two horizontal lines
abline( h=0 , lty=2 ) # no one is shorter than zero
abline( h=272 , lty=1 , lwd=0.5 ) # Wadlow (Alton giant)

mtext( "b ~ dnorm(0,10)" )
xbar <- mean(d2$weight)

for (i in 1:N ) curve( a[i] + b[i]*(x - xbar) , 
      from=min(d2$weight) , to=max(d2$weight) , add=TRUE , 
      col=col.alpha("black",0.2) )


# instead use log-priors
b <- rlnorm( 1e4 , 0 , 1)
dens( b , xlim=c(0,5) , adj=0.1 )
#enforces positive relationships

#redo the plot
plot( NULL , xlim=range(d2$weight) , ylim=c(-100,400) , 
      xlab="weight" , ylab="height" )

# add two horizontal lines
abline( h=0 , lty=2 ) # no one is shorter than zero
abline( h=272 , lty=1 , lwd=0.5 ) # Wadlow (Alton giant)

mtext( "b ~ dlnorm(0,10)" )
xbar <- mean(d2$weight)

# plot with the right constraints
for (i in 1:N ) curve( a[i] + b[i]*(x - xbar) , 
                       from=min(d2$weight) , to=max(d2$weight) , add=TRUE , 
                       col=col.alpha("black",0.2) )


