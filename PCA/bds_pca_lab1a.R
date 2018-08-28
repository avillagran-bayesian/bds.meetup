#
setwd("C:/Alejandro/Research/BDS/Multivariate/PCA")
#
# Introduction to linear algebra
library(matlib)
x <- c(1,2,3,4) #vector
t(x) #transpose
diag(x) #diagonal matrix
t(x)%*%x #result a scalar
x%*%t(x) #result a matrix
x*x #elementwise multiplication
mean(x) #average
n <- length(x); ones <- rep(1,n)
(1/n)*ones%*%x #vector computation of an average
sd(x) #standard deviation of x
sqrt((1/(n-1))*(t(x)%*%x-n*((1/n)*ones%*%x)%*%t((1/n)*ones%*%x))) #std dev 

# Covariance matrix
X <- x%*%t(x)
Det(X) #determinant of X
inv(X) #inverse of X
cov(X)
cor(X)
R(X) #rank of X
#
C <- matrix(c(1,0.7,0.2,0.7,2,-0.8,0.2,-0.8,2.5),3,3)
dim(C)
Det(C)
inv(C)
R(C)
# Compute eigen values and eigen vectors
# Cx=wx
# x is an eigen vector, and w is an eigen value of C
eigen(C)
# SVD of a matrix
# C=U*diag(d)*V'
D <- SVD(C) # Singular value decomposition
D$U%*%t(D$U) # U, V orthonormal 

# Linear algebra applied to Linear Regression
# Predict MPG
cars <- read.delim("cars.tab")
Y <- log(as.matrix(cars[3]))
X <- as.matrix(cbind(rep(1,length(Y)),cars[4:8]))
B <- inv(t(X)%*%X)%*%t(X)%*%Y #OLS Estimation
lm.fit <- lm(log(MPG)~Weight+Drive_Ratio+Horsepower+Displacement+Cylinders,data=cars)
summary(lm.fit)

# Singular value decomposition applied to linear regression
D <- SVD(X)
b <- D$V%*%diag(1/D$d)%*%t(D$U)%*%Y

# Perpendicular projection operator (PPO)
M <- X%*%inv(X%*%t(X))%*%t(X) #PPO
Yhat <- M%*%Y #Predicted values


# =====================
cars <- read.delim("cars.tab")
X <- as.matrix(cars[3:8])

# Hierarchical clustering
d <- dist(scale(X),method="euclidian")
c <- hclust(d,method="ward.D")
plot(c,labels=cars$Car)
k <- 3 # Number of clusters
groups <- as.factor(cutree(c,k))
rect.hclust(c,k,border="red")

Z <- cbind(as.data.frame(cars[-2]),as.data.frame(groups))
View(Z)

Y <- Z[2:7]

#==============================
# Principal component analysis
pca <- prcomp(Y,scale. = TRUE)
