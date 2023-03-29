# define range of values
A_seq <- seq( from=-2 , to=2 , length.out=30 )

# extract posterior samples and simulate observations using them

post <- extract.samples( m5.3_A )
M_sim <- with( post , sapply( 1:30 , # iter over 30 values in A_seq
        function(i) rnorm( 1e3 , a_M + bA_M*A_seq[i] , sigma_M ) ) )
# with(...) saves you time writing post$a_M + post$abA_M*...

# simulate D
D_sim <- with( post , sapply( 1:30 , 
        function(i) rnorm( 1e3 , a + bA*A_seq[i] + bM*M_sim[,i] , sigma ) ) )
# there are 1000 values in M_sim[,i], rnorm takes them one at a time
# to simulate another 1000 variables in D.