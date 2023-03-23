
p_grid <- seq( from=0 , to=1 , length.out=1000 ) 

prob_p <- rep( 1 , 1000 ) # priori

# observing 3 waters in 3 tosses
prob_data <- dbinom( 3 , size=3 , prob=p_grid )

posterior <- prob_data * prob_p
posterior <- posterior / sum( posterior )

samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )



p_grid[ which.max( posterior ) ] # using posterior

chainmode( samples , adj=0.01 ) # using samples

