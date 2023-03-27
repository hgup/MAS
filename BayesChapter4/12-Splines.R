# we use this dataset instead... wigglier
d <- cherry_blossoms
precis(d)
# doy: first day of blossom

plot( doy ~ year , data=d )
# wiggly trend in the cloud

# choose # of knots
d2 <- d[ complete.cases(d$doy) , ] # having no missing values of doy
num_knots <- 30
knot_list <-quantile( d2$year , probs=seq(0,1,length.out=num_knots) )

# choose polynomial degree
# splines::
B <- bs(d2$yea , 
        knots=knot_list[ -c(1,num_knots) ] ,
        degree=3 , intercept=TRUE )
# each row -> year (827) ; each col -> basis function (defining the year span)


# plot the basis functions
plot( NULL , xlim=range(d2$year) , ylim=c(0,1) , xlab="year" , ylab="basis" )
for ( i in 1:ncol(B) ) lines( d2$year , B[,i] )

# B -> basis functions, w -> weights
# model
m4.7 <- quap(
  alist(
      D ~ dnorm( mu , sigma ) , 
      mu <- a + B %*% w , # matrix multiplication (look at model)
      a ~ dnorm( 100 , 10 ) , 
      w ~ dnorm( 0 , 10 ) , 
      sigma ~ dexp(1) 
  ) , 
  data=list( D=d2$doy , B=B ) , 
  start=list( w=rep( 0 , ncol(B)) ) )

precis( m4.7 , depth=2 ) # depth opens up the list of w?

# mean of the weighted basis functions
post <- extract.samples( m4.7 )
w <- apply( post$w , 2 , mean )

# plot the updated basis function with weights
plot( NULL , xlim=range(d2$year) , ylim=c(-6,6) , 
      xlab="year" , ylab="basis * weight" )
for ( i in 1:ncol(B) ) lines( d2$year , w[i] * B[,i] )

# 97% posterior interval for mu at each year
mu <- link( m4.7 )
mu_PI <- apply(mu , 2 , PI , 0.97 )
plot( d2$year , d2$doy , col=col.alpha(rangi2,0.3) , pch=16 ,
      xlab="year" , ylab="first day of blossom" )
shade( mu_PI , d2$year , col=col.alpha("black",0.5) )
