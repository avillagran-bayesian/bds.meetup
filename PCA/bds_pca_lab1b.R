#
setwd("C:/Alejandro/Research/BDS/Multivariate/PCA")
#
cars <- read.delim("cars.tab")
#
# Multivariate analysis: Chernoff faces
library(aplpack)
X <- cars[3:8]
rownames(X) <- as.character(cars$Car)
faces(face.type = 0)
faces(X,face.type = 2)

plot(X[,1:2],bty="n")
a <- faces(X,plot=FALSE)
plot.faces(a,X[,1],X[,2],width=0.5,height=0.35)

#==============================
# Principal component analysis
pca <- prcomp(X,scale. = TRUE)
# sdev - sq root of eigenvalues
# rotation - eigenvectors (columns)
# x - PCA scores
ls(pca)
head(X)
head(pca$x)
#
plot(pca)
summary(pca)
biplot(pca)
# Covariance matrix
C <- cor(X)
#
library(scales)
library(ggplot2)
# Proportion of Variance Explained (PVE)
# Plot scree plot of the PCs after calculating PVEs
pve <- (pca$sdev^2)/sum(pca$sdev^2); nd <- length(pve)
pc <- seq(1,nd)
plot_dta <- as.data.frame(cbind(pc, pve))

ggplot(data=plot_dta, aes(x=pc, y=unlist(pve), group=1)) +
  geom_line(size=1.5) +
  geom_point(size=3, fill="white") +
  xlab("Principal Components") +
  ylab("Proportion of Variance Explained") +
  scale_x_continuous(breaks = c(1:11), minor_breaks = NULL) +
  scale_y_continuous(labels=percent) +
  ggtitle("Scree Plot for Principal Components and Variance")

library(FactoMineR)
pca2 <- PCA(X,graph=FALSE)
ls(pca2)
summary(pca2)
barplot(pca2$eig[,1],main="Eigenvalues",names.arg=1:nrow(pca2$eig))

#
# ===============================
# PRINCIPAL COMPONENTS REGRESSION

# Jolliffe, Ian T. "A Note on the Use of Principal Components in Regression," 
# Journal of the Royal Statistical Society. Series C (Applied Statistics), 
# Vol. 31, No. 3 (1982), pp. 300-303

library(pls)
# Predict MPG
pcr_fit <- pcr(MPG~.,data=X,scale=TRUE,validation="CV")
summary(pcr_fit)

validationplot(pcr_fit, val.type = "MSEP")

pcr_pred5 = predict(pcr_fit, X, ncomp=5)
pcr_pred2 = predict(pcr_fit, X, ncomp=2)