library(rethinking) # for dens

# sampling from a grid-approximate posterior

# First, grid approximate the posterior

# Note posterior: Pr(p|data)
# parameter values in x-axis of posterior dist function
p_grid <- seq( from=0 , to=1 , length.out=1000 ) 

prob_p <- rep( 1 , 1000 ) # priori
prob_data <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- prob_data * prob_p
posterior <- posterior / sum( posterior )


# Draw 10000 samples from predictors
samples <- NULL
# we are drawing p values (some very common (mode), some RARE (tails))
gen_sample <- function(){
return( sample( p_grid , prob=posterior , size=1e4 , replace=TRUE ) )
} 
samples <- gen_sample()
# samples (p-values in y-axis) vs index (each of the samples in x-axis)
plot( samples ) 

# create a frequency density
dens( samples )
