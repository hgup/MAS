# multinomial Gaussian distribution

vcov( m4.1 )

# variances
diag( vcov( m4.1 ) )

# correlation
cov2cor( vcov( m4.1 ) )
# correlations b/w sigma and mu ~ 0 => Independence

# draw samples from multi-dimentional posterior
post <- extract.samples( m4.1 , n=1e4 )

head(post)
# two columns: \sigma and \mu

# comparing sample from the model
precis(post)
precis( m4.1 )

# comparing the plot with grid approx from ./2-gridApprox...
plot( post[[1]] , post[[2]] , cex=0.5 , pch=16 ,
      col=col.alpha(rangi2,0.1) )
