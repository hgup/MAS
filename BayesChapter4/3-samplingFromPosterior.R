# sample combinations of two parameters from the posterior
# - randomly sample row # (index) in post 
#   in proportion to values in post$prob
# - pull out the parameter (mu,sigma) from those rows (#)

sample.rows <- sample( 1:nrow(post) , size=1e4 , replace=TRUE , 
                       prob=post$prob )

sample.mu <- post$mu[ sample.rows ]
sample.sigma <- post$sigma[ sample.rows ]

# rethinking::col.alpha()
plot( sample.mu , sample.sigma , cex=0.5 , pch=16 ,
      col=col.alpha(rangi2,0.1) )


## Marginal Posterior densities of \mu and \sigma
dens( sample.mu )
dens( sample.sigma )

# summarize widths of densities
PI( sample.mu )
PI( sample.sigma )


# weak priors so, splice in a more informative prior mu(sd=0.1)

m4.2 <- quap(
  alist(
      height ~ dnorm( mu , sigma ) , 
      mu ~ dnorm( 178 , 0.1 ) , 
      sigma ~ dunif( 0 , 50 )
  ) , data=d2 )
precis( m4.2 )
# the priorestimate for \mu is very concentrated around the prior