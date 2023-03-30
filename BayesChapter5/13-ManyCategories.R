data("milk")
d <- milk
levels(d$clade)
# d$clade is a factor... that is why coercion happens
# if it were a string... we would need to convert it to a factor (line 29)
# coercing the factor to an integer
d$clade_id <- as.integer( d$clade ) 

# measure average milk energy on each clade ----

d$K <- standardize( d$kcal.per.g )

m5.9 <- quap(
  alist(
  K ~ dnorm( mu , sigma ) , 
  mu <- a[clade_id] , 
  a[clade_id] ~ dnorm( 0 , 0.5 ) , 
  sigma ~ dexp( 1 )
  ) , data=d
)

labels <- paste( "a[", 1:4 , "]:" , levels(d$clade) , sep="" )
plot( precis( m5.9 , depth=2 , pars="a" ) , labels=labels , 
      xlab="expected kcal (std)" )

# let's add another category and have some fun ----
set.seed(63)
house_labels <- c( "Sathya" , "Dharma" , "Shanti" , "Prema" )
d$house <- as.factor( sample( rep(house_labels,each=8) , size=nrow(d) ) )
d$house_id <- as.integer( d$house )

m5.10 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) , 
    mu <- a[clade_id] + b[house_id], 
    a[clade_id] ~ dnorm( 0 , 0.5 ) , 
    b[house_id] ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d
)
labels <- c(paste( "a[", 1:4 , "]:" , levels(d$clade) , sep="" ),
            paste( "b[", 1:4 , "]:" , levels(d$house) , sep="" ) )
plot( precis( m5.10 , depth=2 , pars=c("a","b") ) , labels=labels , 
      xlab="expected kcal (std)" )
