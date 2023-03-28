# checking correlations to test the dag5.1
cor( d$D , d$M )
cor( d$D , d$A )
cor( d$A , d$M )

# deduce the implication D is independent of M conditioning on A
# D _||_ M | A on dag5.2
DMA_dag2 <- dagitty('dag{ D <- A -> M }')
impliedConditionalIndependencies( DMA_dag2 )

# on dag5.1
DMA_dag1 <- dagitty('dag{ D <- A -> M -> D}')
impliedConditionalIndependencies( DMA_dag2 )
