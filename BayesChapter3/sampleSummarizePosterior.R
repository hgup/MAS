source("./BayesChapter3/samplingGridApprox.R")

sum( posterior[ p_grid < 0.5 ]) # kind of like a CDF of the posterior



sum( samples < 0.5 ) / 1e4 # answer doesnt match book (0.1726), since sampling is random
samples <- gen_sample()
# rerun

quantile( samples , 0.8 )

quantile( samples , c( 0.1 , 0.9 ) ) # encloses 80% of the probaility mass
