
import os
cwd = os.getcwd()
path = 'C:\Alejandro\Research\BDS\Multivariate\PCA'
os.chdir(path)

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import scale 
from sklearn.decomposition import PCA
from sklearn.linear_model import LinearRegression
from sklearn import model_selection
from sklearn.metrics import mean_squared_error
df=cars
df.head()
df.info()
X=df.drop(['Country','Car'],axis=1)

# PRINCIPAL COMPONENT ANALYSIS
pca = PCA()
X_reduced = pca.fit_transform(scale(X))
pca = PCA().fit(X)
plt.plot(np.cumsum(pca.explained_variance_ratio_))
plt.xlabel('Number of components')
plt.ylabel('Cumulative explained variance')

# PRINCIPAL COMPONENT REGRESSION
y=df.MPG
n = len(X_reduced)
kf_5 = model_selection.KFold( n_splits=5, shuffle=True, random_state=1)

regr = LinearRegression()
mse = []

# Calculate MSE with only the intercept (no principal components in regression)
score = -1*model_selection.cross_val_score(regr, np.ones((n,1)), y.ravel(), cv=kf_5, scoring='neg_mean_squared_error').mean()    
mse.append(score)

# Calculate MSE using CV for the 6 principle components, adding one component at the time.
for i in np.arange(1, 6):
    score = -1*model_selection.cross_val_score(regr, X_reduced[:,:i], y.ravel(), cv=kf_5, scoring='neg_mean_squared_error').mean()
    mse.append(score)
    
# Plot results    
plt.plot(mse, '-v')
plt.xlabel('Number of principal components in regression')
plt.ylabel('MSE')
plt.title('MPG')
plt.xlim(xmin=-1);

np.cumsum(np.round(pca.explained_variance_ratio_, decimals=4)*100)

pca2 = PCA()
# Split into training and test sets
X_train, X_test , y_train, y_test = model_selection.train_test_split(X, y, test_size=0.5, random_state=1)

# Scale the data
X_reduced_train = pca2.fit_transform(scale(X_train))
n = len(X_reduced_train)

# 5-fold CV, with shuffle
kf_5 = model_selection.KFold( n_splits=5, shuffle=True, random_state=1)

mse = []

# Calculate MSE with only the intercept (no principal components in regression)
score = -1*model_selection.cross_val_score(regr, np.ones((n,1)), y_train.ravel(), cv=kf_5, scoring='neg_mean_squared_error').mean()    
mse.append(score)

# Calculate MSE using CV for the 6 principle components, adding one component at the time.
for i in np.arange(1, 6):
    score = -1*model_selection.cross_val_score(regr, X_reduced_train[:,:i], y_train.ravel(), cv=kf_5, scoring='neg_mean_squared_error').mean()
    mse.append(score)

plt.plot(np.array(mse), '-v')
plt.xlabel('Number of principal components in regression')
plt.ylabel('MSE')
plt.title('MPG')
plt.xlim(xmin=-1);

X_reduced_test = pca2.transform(scale(X_test))[:,:3]

# Train regression model
regr = LinearRegression()
regr.fit(X_reduced_train[:,:3], y_train)

# Prediction with test data
pred = regr.predict(X_reduced_test)
mean_squared_error(y_test, pred)