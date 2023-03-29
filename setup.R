install.packages(c("coda","mvtnorm","devtools","loo","dagitty","shape"))

# for MCMC algorithms
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))


devtools::install_github("rmcelreath/rethinking@slim")
