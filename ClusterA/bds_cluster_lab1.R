
setwd("C:/Alejandro/Research/BDS/Multivariate/Cluster")
# Yellowstone pollen data
ypolsqrt <- read.csv("yellpolsqrt.csv")
ypolsqrt$Veg <- as.factor(ypolsqrt$Veg)
levels(ypolsqrt$Veg) <-
  c("Steppe","Lodgepole","Trans","Subalpine","Alpine")
Veg<-ypolsqrt$Veg

X <- as.matrix(ypolsqrt[,4:35]) # just the pollen data
X.dist <- dist(scale(X))

# k-means clustering of Yellowstone pollen data
library(cluster)
kmean.cls <- kmeans(X, centers=5)
class.table.km <- table(Veg, kmean.cls$cluster)
mosaicplot(class.table.km, color=T)

# Hierarchical clustering
hier.cls <- hclust(X.dist, method = "ward.D2")
plot(hier.cls, labels=Veg, cex=.7)
# Cut dendrogram to give 5 clusters
nclust <- 5
clusternum <- cutree(hier.cls, k=nclust)
class.table.hier <- table(Veg, clusternum)
mosaicplot(class.table.hier, color=T)
#
plot(hier.cls, labels=Veg, cex=.7)
clusters <- cutree(hier.cls,k=5)
rect.hclust(hier.cls,k=5,border="red")

# Partitioning around mediods
# "pam" clustering of Yellowstone pollen data
pam.cls <- pam(X, k=5)
plot(pam.cls)

