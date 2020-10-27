import numpy as np
import matplotlib.pyplot as plt
from sklearn.svm import SVR

#set hyperparameter
C =1 # regularization
e = 0.5 # Intensitivität
nd =51 # data
f = 0.5 # noisy
np.random.seed(0)

# create linear function

x = np.linspace(0,5,nd).reshape(-1,1)
X = np.hstack((x**0,x**1)) # create input variable
w = np.ones((X.shape[1],1))

ys = X @ w
Y = ys + f * np.random.randn(*ys.shape)

lr = SVR(kernel ='linear', C=C, epsilon=e).fit(x,Y.ravel())
print('the linear regression coefficient is:' ,lr.coef_)
print('the bias of the linear regression is:' ,lr.intercept_)
yp=lr.predict(x)
# show the result

plt.figure(1)
plt.plot(x,Y,'C1.',x,yp,'C2-')
plt.plot(lr.support_vectors_, Y[lr.support_],'C1o', mfc='white')
plt.plot(x,yp+e,'k--',x,yp-e, 'k--')
plt.xlabel('input')
plt.ylabel('target')

plt.show()