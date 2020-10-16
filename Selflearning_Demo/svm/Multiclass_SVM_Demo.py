# Demo for svm used in multi-class classification

import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets, svm
from sklearn.preprocessing import StandardScaler

C = 1 # regularization
ng = 101 # gitterpunkt
iris = datasets.load_iris()

X=iris.data[:,2:4]
y=iris.target

# pre processing

sca = StandardScaler().fit(X)
clf = svm.SVC(decision_function_shape='ovo',kernel='linear',probability=True)
clf.fit(sca.transform(X), y)

# test set preparation

x1 = np.linspace(1,7,ng)
x2 = np.linspace(0,2.5, ng)
X1, X2 = np.meshgrid(x1,x2)
XX = np.c_[X1.ravel(),X2.ravel()]
Pred = clf.predict(sca.transform(XX)).reshape(X1.shape)

# show the result

plt.figure(1)

plt.plot(X[y == 0, 0],X[y == 0, 1],'C1.', X[y == 1, 0], X[y == 1, 1],'C2*', X[y == 2, 0], X[y == 2, 1],'C3^' )
plt.contour(X1, X2, Pred, cmap = plt.cm.winter, alpha = 0.5)
