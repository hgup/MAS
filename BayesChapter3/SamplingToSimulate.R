dbinom( 0:2 , size=2 , prob=0.7 )

# random binominal
rbinom( 10 , size=2 , prob=0.7 )

# find percentages
dummy_w <- rbinom( 1e5 , size=2 , prob=0.7 )
table(dummy_w)/1e5


dummy_w <- rbinom( 1e5 , size=9 , prob=0.7 )
simplehist( dummy_w , xlab="dummy water count" )

table(dummy_w)/1e5
# shows that (1-0.26819) of the time. the expected observations do not have p=0.7

# simulated predicted observations for a single value of p
w <- rbinom( 1e4 , size=9 , prob=0.6 )
simplehist ( w )

# first generate sample (grid approx)
p_grid <- seq( from=0 , to=1 , length.out=1000 )
prob_p <- rep( 1 , 1000 )
prob_data <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- prob_data * prob_p
posterior <- posterior/sum(posterior)

samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )
# sample( from_VALUES , given their probabilities, size of the sample, with replacement? can repeat?)

# propagate parameter uncertainity
w <- rbinom( 1e4 , size=9 , prob=samples )
simplehist(w)
