# a demo for analysising how the number of the nearest neighbor influence on the final result

import numpy as np
import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsRegressor

nd = 101 # train set
k = np.arange(1,41) #define the number of the nearest neighbor
f=0.05 #gauss noisy

np.random.seed(1)

# function establish

x = np.linspace(0, 2, nd).reshape(-1,1) # input variable
ys = 1 -np.exp(-2*x)
y = ys + f + np.random.randn(*x.shape) # output variable

# create test set

step = x[1] - x[0]

xt = x + 0.5 * step
yst = 1 - np.exp(-2*xt)
yt = yst + f * np.random.randn(*xt.shape)

# create evaluate list

e_train = np.zeros(k.shape)
e_test = np.zeros(k.shape)

# evaluate the hyperparamete k

for i in range(k.size) :
    knn = KNeighborsRegressor(n_neighbors=k[i]).fit(x,y)
    yp = knn.predict(x)
    ypt = knn.predict(xt)
    I =np.arange(k[i]//2, x.size-k[i]//2) # select the valuable punkt
    e_train[i] = np.linalg.norm(yp[I]- y[I])/np.sqrt(I.size) # RMSE in train set
    e_test[i] = np.linalg.norm(ypt[I] - yt[I]) / np.sqrt(I.size) #RMSE in test set

# show the result:

plt.figure(1)
plt.plot(k,e_train,'C1-',k, e_test,'C2-')
plt.xlabel('number of neighbor')
plt.ylabel('RMSE')









