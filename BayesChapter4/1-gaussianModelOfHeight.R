

# d$age -> d extract age -
# "extract the column named height from data frame d"
d2 <- d[ d$age >= 18 , ]

dens(d2$height)
dens(d$height)

curve( dnorm( x , 178 , 20 ) , from=100 , to=250 ) # mean prior
curve( dunif( x , 0 , 50 ) , from=-10 , to=60 ) # sd prior

# prior predictive simulation
sample_mu <- rnorm( 1e4 , 178 , 20 ) # sample the means
sample_sigma <- runif( 1e4 , 0 , 50 ) # sample the sd's

# use those samples to sample the heights
prior_h <- rnorm( 1e4 , sample_mu , sample_sigma ) 

# expected distribution of heights averaged over the priors
dens( prior_h )
# vaguely bell shaped density with thick tails









