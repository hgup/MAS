dag5.1 <- dagitty( "dag{ A -> D; A -> M; M -> D}" )
coordinates(dag5.1) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.1 , cex=1.5 , lwd=3 )

dag5.2 <- dagitty( "dag{ A -> D; A -> M}" )
coordinates(dag5.1) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
drawdag( dag5.1 , cex=1.5 , lwd=3 )