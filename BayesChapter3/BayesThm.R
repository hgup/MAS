# Syntax P(Positive | Vampire) ~ Pr_Positive_Vampire

Pr_Positive_Vampire <- 0.95
Pr_Positive_Mortal <- 0.01
Pr_Vampire <- 0.001 # from the population
Pr_Positive <- Pr_Positive_Vampire * Pr_Vampire + 
  Pr_Positive_Mortal * ( 1 - Pr_Vampire )

# inside brackets => It evaluates and sends the value to prompt
( Pr_Vampire_Positive <- Pr_Positive_Vampire * Pr_Vampire / Pr_Positive )
