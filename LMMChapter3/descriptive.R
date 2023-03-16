ratpup <- read.table("C:\\temp\\rat_pup.dat", h = T)
ratpup

attach(ratpup)

treatment <- ordered(treatment, levels=c("High","Low","Control"))

g <-
function(x)c(N=length(x), MEAN=mean(x,na.rm=TRUE),SD=sd(x,na.rm=TRUE), MIN=min(x,na.rm=TRUE),MAX=max(x,na.rm=TRUE))
summarize(weight,by=llist(treatment,sex),g)

library(lattice)
library(grid)

bwplot(weight ~ sex|treatment, data=ratpup, aspect = "fill", ylab="Birth Weights", xlab="SEX", main = "Boxplots of birth wights for levels of treatments by sex")

ranklit <- litsize+0.01*litter
sort(ranklit)
ranklit
ranklit <- factor(ranklit)
levels(ranklit) <- c( "1","2", "3","4","5","6","7","8","9","10", "11","12", "13","14","15","16","17","18","19","20", "21","22", "23","24","25","26","27")

ranklit

plt <- bwplot(weight ~ ranklit | treatment*sex, data=ratpup, aspect="fill", ylab= "Birth Weights", xlab="",layout= c(3,2))

plt
update(plt, par.settings = list(fontsize = list(text = 10, points = 5)))

detach(ratpup)
