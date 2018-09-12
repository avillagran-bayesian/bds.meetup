#
A <- c(7,8,-3,8,0,1,-3,1,9)
A <- matrix(A,nrow=3,ncol=3,byrow=FALSE)
#
library(matlib)
# Singular value decomposition
svd <- SVD(A)
# Using eigen function
eig <- eigen(A)
# PCA 
pca <- prcomp(A,scale=FALSE)

#
B <- c(5,2,2,2)
B <- matrix(B,nrow=2,ncol=2,byrow=FALSE)
#
# Singular value decomposition
svd <- SVD(B)
# Using eigen function
eig <- eigen(B)

#
C <- c(90,50,50,90)
C <- matrix(C,nrow=2,ncol=2,byrow=FALSE)
#
# Singular value decomposition
svd <- SVD(C)
# Using eigen function
eig <- eigen(C)

# Turtles data
# Jolicoeur and Mosimann (1960)
turtles <- read.table(file = "http://www.public.iastate.edu/~maitra/stat501/datasets/turtles.dat", col.names = c("gender", "carapace length",  "carapace width", "carapace height"))
head(turtles)
# gender = 1 (female), gender = 2 (male)
turtles.m <- turtles[turtles$gender == 2, -1]
#
X <- log(turtles.m)
cov(X)
#
S <- (0.001)*c(11.072,8.019,8.160,8.019,6.417,6.005,8.160,6.005,6.773)
S <- matrix(S,nrow=3,ncol=3,byrow=FALSE)
#
eig <- eigen(S)
#
svd <- SVD(S)
#
pca <- prcomp(S,scale=TRUE)
summary(pca)
#
# y1 = 0.683*ln(length)+0.51*ln(width)+0.523*ln(height)