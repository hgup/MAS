data("Howell1")
d <- Howell1
str(d)

# Indicator Variables: there is more uncertainity to males than females----

mu_female <- rnorm( 1e4 , 178 , 20 ) # alpha
mu_male <- rnorm( 1e4 , 178 , 20 ) + rnorm( 1e4 , 0 , 10 ) # alpha + beta_m
precis( data.frame( mu_female , mu_male ) )

# Index Variables: good to go----

# define a new attribute
d$sex <- ifelse( d$male==1 , 2 , 1 )
# 1 -> female, 2 -> male

# Model with Index Variables----

m5.8 <- quap(
  alist(
    height ~ dnorm( mu , sigma ) , 
    sigma ~ dunif( 0 , 50 ) , 
    mu <- a[sex] , 
    a[sex] ~ dnorm( 178 , 20 ) 
  ) , data=d )

precis( m5.8 , depth=2 ) # show vector parameters a[sex]

# expected difference of heights ----
post <- extract.samples( m5.8 ) # posterior samples data frame
post$diff_fm <- post$a[,1] - post$a[,2]
precis( post , depth=2 )
