
# Ridge regression
setwd("C:/Alejandro/Research/BDS/Regularization/")
#
library(MASS)
set.seed(20)
N <- 20 # Sample size
x1 <- rnorm(n=N)
x2 <- rnorm(n=N,mean=x1,sd=0.01)
y <- rnorm(n=N,mean=3+x1+x2)

# OLS
lm(y~x1+x2)$coef
# RIDGE
lm.ridge(y~x1+x2,lambda=1)
lm.ridge(y~x1+x2,lambda=5)

