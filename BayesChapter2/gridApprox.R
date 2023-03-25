n <- 30

# we call it a grid because it represents the combination of
# all possible parameter values
p_grid <- seq( from=0 , to=1 , length.out=n )

# use any one of the priors
#prior <- rep( 1 , n )
prior <- ifelse( p_grid < 0.5 , 0 , 1 )
prior <- exp( -5*abs( p_grid - 0.5 ) )

# Grid approx procedure


# compute the likelihood of every p value, Pr(p|data)
likelihood <- dbinom( 6 , size=9 , prob=p_grid )

# find the posterior. Pr(data|p) * 
unstd.posterior <- likelihood * prior

posterior <- unstd.posterior/sum(unstd.posterior)

plot( p_grid , posterior , type="b" ,
      xlab="probability of water" , ylab="posterior probability" )
mtext( "20 points" )
