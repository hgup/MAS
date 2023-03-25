mu.list <- seq( from=150 , to=160 , length.out=100 ) # grid for mu
sigma.list <- seq( from=7 , to=9 , length.out=100 ) # grid for sigma

# (mu x sigma) ordered pairs
post <- expand.grid( mu=mu.list , sigma=sigma.list ) 

# note that we use d2$height.
# we fit height data with all possible combination of priors
# we add another column to post called Log-Likelihood obtained by
# summing all the log-likelihood of observations with the priors
post$LL <- sapply( 1:nrow(post) , function(i) sum(
  dnorm( d2$height , post$mu[i] , post$sigma[i] , log=TRUE ) ) )

# product of likelihoods: data * mu * sigma
post$prod <- post$LL + dnorm( post$mu , 178 , 20 , log=TRUE ) +
  dunif( post$sigma , 0 , 50 , log=TRUE )

# posterior probability standardized. Why max?
post$prob <- exp( post$prod - max(post$prod) )

# rethinking::
contour_xyz( post$mu , post$sigma , post$prob )
image_xyz( post$mu , post$sigma , post$prob )

