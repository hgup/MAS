dag5.1 <- dagitty( "dag{ A -> D; A -> M; M -> D}" )
coordinates(dag5.1) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.1 , cex=1.5 , lwd=3 )

dag5.2 <- dagitty( "dag{ A -> D; A -> M}" ) # M -> D removed
coordinates(dag5.2) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.2 , cex=1.5 , lwd=3 )

dag5.3 <- dagitty( "dag{ A -> D; M -> D}" ) # A -> M removed
coordinates(dag5.3) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.3 , cex=1.5 , lwd=3 )
