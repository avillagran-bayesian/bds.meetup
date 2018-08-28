
import os
cwd = os.getcwd()
path = 'C:\Alejandro\Research\BDS\LRegression'
os.chdir(path)

import pandas as pd
import statsmodels.api as sm

df = pd.read_csv('Boston.csv', index_col=0)
df.head()
Y = df.medv
X = df.lstat
X = sm.add_constant(X)

lm = sm.OLS(Y,X)
result = lm.fit()

print(result.summary())

new = pd.DataFrame([[1, 5], [1, 10], [1, 15]], columns=['Intercept', 'lstat'])
result.predict(new)


import seaborn as sns
sns.regplot('lstat', 'medv', df, line_kws = {"color":"r"}, ci=None)
fitted_values = pd.Series(result.fittedvalues, name="Fitted Values")
residuals = pd.Series(result.resid, name="Residuals")
sns.regplot(fitted_values, residuals, fit_reg=False)
s_residuals = pd.Series(result.resid_pearson, name="S. Residuals")
sns.regplot(fitted_values, s_residuals,  fit_reg=False)

from statsmodels.stats.outliers_influence import OLSInfluence
leverage = pd.Series(OLSInfluence(result).influence, name = "Leverage")
sns.regplot(leverage, s_residuals,  fit_reg=False)