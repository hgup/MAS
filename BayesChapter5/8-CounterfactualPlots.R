# Plotting Intervention Variables against Counterfactual vars----
m5.3_A <- quap(
  alist(
    ## A -> D <- M
      D ~ dnorm( mu , sigma ) ,
      mu <- a + bM * M + bA * A , 
      a ~ dnorm( 0 , 0.2 ) , 
      bM ~ dnorm( 0 , 0.5 ) , 
      bA ~ dnorm( 0 , 0.5 ) ,
      sigma ~ dexp( 1 ) ,
    ## A -> M
      M ~ dnorm( mu_M , sigma_M ) , 
      mu_M <- a_M + bA_M * A , 
      a_M ~ dnorm( 0 , 0.2 ) , 
      bA_M ~ dnorm( 0 , 0.5 ) , 
      sigma_M ~ dexp( 1 )
  ) , data=d
)

# simulate what happens when we manipulate A

A_seq <- seq( from=-2 , to=2 , length.out=30 )
# 30 imaginary interventions

# simulate in this order both: M then D

#prep data
sim_dat <- data.frame( A=A_seq )

# simulate M and then D, using A_seq
s <- sim( m5.3_A , data=sim_dat , vars=c("M","D") ) # list of M and D

# colMeans is pretty useful here: sim gives 1000 different rows
# each row having a different sample
# the column representing usual observed values of data (here, states)
# the cell having the Marriage or divorce rate
# using colMeans allows us to average the rates for a particular state
# and outputs a list of "mean" divorce rates of the 26 states
plot( sim_dat$A , colMeans(s$D) , ylim=c(-2,2) , type="l" ,
      xlab="manipulated A" , ylab="counterfactual D" )

shade( apply(s$D,2,PI) , sim_data$A )
mtext( "Total counterfactual effect of A on D" )

# against M
plot( sim_data$A , colMeans(s$M) , ylim=c(-2,2) , type="l" , 
      xlab="manipulated A" , ylab="counterfactual M" )
shade( apply(s$M,2,PI) , sim_data$A )
mtext( "Total counterfactual effect of A on M" )

# Numerical summaries----
# EXAMPLE: calculate the expected causal effect of increasing 
# median age at marriage from 20 to 30

# new data frame, standardized to mean 26.1 and std dev 1.24 
# values come from precis(d$MedianAgeMarriage)

sim2_dat <- data.frame( A=( c(20,30) - 26.1) / 1.24 )
s2 <- sim( m5.3_A , data=sim2_dat , vars=c("M","D") )
mean( s2$D[,2] - s2$D[,1] )

# COUNTERFACTUAL RESULT: manipulating M, for an average state with A=0----

sim_dat <- data.frame( M=seq( from=-2 , to=2 , length.out=30 ) , A =0 )
s <- sim( m5.3_A , data=sim_dat , vars="D" )
plot( sim_dat$M , colMeans(s) , ylim=c(-2,2) , type="l" , 
      xlab="Manipulated M" , ylab="Counterfactual D" )
shade( apply( s , 2 , PI ) , sim_dat$M )
mtext( "Total countefactual effect of M on D" )
