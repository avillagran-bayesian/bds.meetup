#
setwd("C:/Alejandro/Research/BDS/Regularization/")
#
# https://onlinecourses.science.psu.edu/stat857/node/155/
library(car)
library(ridge)
data(longley, package="datasets")
View(longley)
# Develop a model to predict GNP.deflator
X <- longley[,2:7]
Y <- longley[,1]
# Compute correlations
round(cor(X), 2) 
# Training set
set.seed(100)
trainingIndex <- sample(1:nrow(X), 0.8*nrow(X)) # indices for 80% training data
trainingData <- X[trainingIndex, ]; trainingY <- Y[trainingIndex]
testData <- X[-trainingIndex, ]; testY <- Y[-trainingIndex]

# Linear regression model
lm.fit <- lm(trainingY~.,data=trainingData)
summary(lm.fit)
vif(lm.fit) # Higher than 10 => multicollinearity
# Prediction
pred.lm <- predict(lm.fit,testData)
compare <- cbind(actual=testY,pred.lm)
# Accuracy
mean (apply(compare, 1, min)/apply(compare, 1, max)) 

# Ridge regression
Ridge.fit <- linearRidge(trainingY~.,data=trainingData)
summary(Ridge.fit)
# Prediction
pred.ridge <- predict(Ridge.fit,testData)
compare <- cbind(actual=testY,pred.ridge)
# Accuracy
mean (apply(compare, 1, min)/apply(compare, 1, max)) 

# Removing culprits
# GNP, Population, and Year
lm.fit2 <- lm(trainingY~.,data=trainingData[,-c(1,4,5)])
summary(lm.fit2)
vif(lm.fit2) # Higher than 10 => multicollinearity
# Prediction
pred.lm2 <- predict(lm.fit2,testData)
compare <- cbind(actual=testY,pred.lm2)
# Accuracy
mean (apply(compare, 1, min)/apply(compare, 1, max)) 
