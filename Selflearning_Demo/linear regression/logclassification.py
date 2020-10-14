import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression

# define parameter
C = 1e16  # regularization
ng = 51
iris = load_iris()

X = iris.data[:, 2:4]
y = iris.target

# logistic regression

sca = StandardScaler().fit(X, y) # standardization
clf = LogisticRegression(C=C, solver='lbfgs', multi_class='auto').fit(sca.transform(X),y)

# calculate the probability

x1 = np.linspace(1,7, ng)
x2 = np.linspace(0,2.5,ng)
X1, X2 = np.meshgrid(x1, x2)
XX = np.c_[X1.ravel(), X2.ravel()] # establish a gitter
prob = clf.predict_proba(sca.transform(XX)).reshape(ng, ng, -1)

# show the result and boundary

plt.figure(1)
plt.plot(X[y == 0, 0], X[y == 0, 1], 'C0.', X[y == 1, 0], X[y == 1, 1], 'C1.', X[y == 2, 0], X[y == 2, 1], 'C2.')
plt.xlabel('feature 1')
plt.ylabel('feature 2')
plt.contour(X1,X2, prob[:,:,0]-prob[:,:,1], [0])
plt.contour(X1, X2, prob[:,:,1]-prob[:,:,2], [0])
# plt.contour(X1, X2, prob[:,:,0]-prob[:,:,2], [0])
plt.show()




