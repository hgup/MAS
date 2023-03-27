sim.height <- sim( m4.3 , data=list(weight=weight.seq) )
#sim.height <- sim( m4.3 , data=list(weight=weight.seq) ,n=1e4)

str(sim.height)
# simulated heights, not distributions of plausible average height, \mu

height.PI <- apply( sim.height , 2 , PI , prob=0.89 )
#height.PI <- apply( sim.height , 2 , PI , prob=0.67 )
mu.HPDI <- apply( mu , 2 , HPDI)
# raw data
plot( height ~ weight , d2 , col=col.alpha(rangi2, 0.5) )

# draw MAP line
lines( weight.seq , mu.mean )

# draw HPDI region for line
shade( mu.HPDI , weight.seq )

# draw PI region for simulated heights
shade( height.PI , weight.seq )
