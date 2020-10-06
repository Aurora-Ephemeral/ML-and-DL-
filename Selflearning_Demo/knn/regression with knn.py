import numpy as np
import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsRegressor

num = 51 # number of data set
k = 11 # defintion of nearest neighbor point
f = 0.05 # n

np.random.seed(0) # freeze the random

# data preparation

x = np.linspace(0, 2, num).reshape(-1,1) # set input variable and transform into an vector:
ys = 1 - np.exp(-2 * x)
y = ys + f * np.random.randn(*x.shape)

plt.figure(1)
plt.plot(x,y,'ro')
plt.title('original train set')
plt.xlabel('input variable')
plt.ylabel('output variable')

# train regression learner

knn = KNeighborsRegressor(n_neighbors=k)
Y_pred = knn.fit(x,y).predict(x)

# show the training result:

plt.figure(2)
plt.plot(x,y,'ro',x[k//2:],Y_pred[k//2:],'b-')

