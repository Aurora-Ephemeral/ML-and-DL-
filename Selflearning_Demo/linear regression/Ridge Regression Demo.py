# Demo for using ridge regression

import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import Ridge

# data preparation
nd = 11
nt = 101
nb = 11 # order of polynomial + bias
a = 0.01 # regularization coefficient
f = 0.1 # noisy coefficient
np.random.seed(0)

#input variable
u = np.linspace(0,2,nd) # training data
ut = np.linspace(0,2, nt) # test data
ys = 1- np.exp(-2*u)
yts = 1 - np.exp(-2*ut)
y = ys + f * np.random.randn(*ys.shape) # target for training
yt = yts + f * np.random.randn(*yts.shape)

# create polynomial
X = np.ones((nd, nb))
Xt = np.ones((nt, nb))

for i in range(nb):
    X[:,i] = u**i
    Xt[:,i] = ut**i

# train a ridge regression

clf = Ridge(alpha=a)
clf.fit(X,y)
yp = clf.predict(Xt)

# show the result
plt.figure(1)
plt.plot(ut,yt, 'C1.', ut, yp, 'C2-')



