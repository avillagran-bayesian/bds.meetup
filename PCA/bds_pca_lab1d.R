#
setwd("C:/Alejandro/Research/BDS/Multivariate/")
#
library(rrr)
library(matlib)
data(tobacco)
View(tobacco)
#
# Question: How to build a predictive model based on 
# a multivariate response?
tobacco_x <- tobacco[,4:9]; tobacco_y <- tobacco[,1:3]
X <- data.matrix(tobacco_x,rownames.force = NA)
Y <- data.matrix(tobacco_y,rownames.force = NA)
r <- R(X)
# Regular approach
mlm <- lm(Y~X)
summary(manova(mlm))
# Using reduced rank regression
mreg <- rrr(tobacco_x, tobacco_y, rank = 1)
mreg$B
# Using PCR on Y
pca <- prcomp(Y,scale. = FALSE)
# sdev - sq root of eigenvalues
# rotation - eigenvectors (columns)
# x - PCA scores
summary(pca)
#
Yt <- pca$x[,1]
lm <- lm(Yt~X)
summary(lm)