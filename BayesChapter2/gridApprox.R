n <- 30

p_grid <- seq( from=0 , to=1 , length.out=n )

# use any one of the priors
#prior <- rep( 1 , n )
prior <- ifelse( p_grid < 0.5 , 0 , 1 )
prior <- exp( -5*abs( p_grid - 0.5 ) )

likelihood <- dbinom( 6 , size=9 , prob=p_grid )

unstd.posterior <- likelihood * prior

posterior <- unstd.posterior/sum(unstd.posterior)

plot( p_grid , posterior , type="b" ,
      xlab="probability of water" , ylab="posterior probability" )
mtext( "20 points" )
