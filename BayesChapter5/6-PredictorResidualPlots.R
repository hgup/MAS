
m5.4 <- quap(
  alist(
    M ~ dnorm( mu , sigma ) , 
    mu ~ a + bAM * A , # why bAM : Age of Marriage
    a ~ dnorm( 0 , 0.2 ) , 
    bAM ~ dnorm( 0 , 0.5 ) , 
    sigma ~ dexp(1)
  ) , data=d
)

# compute residuals: observed - predicted (how to remember?)
# residual ~ (how much of it is left to be predicted)
# (loosely, perfection ~ observed = 100%)

mu <- link(m5.4) # posterior samples
mu_mean <- apply( mu , 2 , mean )
mu_resid <- d$M - mu_mean 
# conditioned on age of marriage ( already explaining the mean as much as it can )

plot( d$M ~ mu_resid )
plot( d$D ~ mu_resid ) # bottom left

