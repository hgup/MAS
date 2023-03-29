# waffle divorce ----
dag5.1 <- dagitty( "dag{ A -> D; A -> M; M -> D}" )
coordinates(dag5.1) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.1 , cex=1.5 , lwd=3 )

dag5.2 <- dagitty( "dag{ A -> D; A -> M}" ) # M -> D removed
coordinates(dag5.2) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.2 , cex=1.5 , lwd=3 )

dag5.3 <- dagitty( "dag{ A -> D; M -> D}" ) # A -> M removed
coordinates(dag5.3) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.3 , cex=1.5 , lwd=3 )

# milk ----
dag5.4 <- dagitty( "dag{ M -> N; M -> K ; N -> K}" )
coordinates(dag5.4) <- list( x=c(M=0,K=1,N=2) , y=c(M=0,K=1,N=0) )
drawdag( dag5.4 , cex=1.5 , lwd=3 )

dag5.5 <- dagitty( "dag{ M <- N ; M -> K ; N -> K}" )
coordinates(dag5.5) <- list( x=c(M=0,K=1,N=2) , y=c(M=0,K=1,N=0) )
drawdag( dag5.5 , cex=1.5 , lwd=3 )

dag5.6 <- dagitty( "dag{ M<- @ ->N ; M -> K <- N" )
coordinates(dag5.6) <- list( x=c(M=0,K=1,N=2) , y=c(M=0,K=1,N=0) )
drawdag( dag5.6 , cex=1.5 , lwd=3 )
