import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.datasets import make_moons
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC

# set hyperparameter
C = 0.9 # Regularization
sigma = 1 # Kernel function: Gauss
ng = 101

# Data preparation and pre processing
X,y = make_moons(n_samples=150, noise=0.3, random_state=42)
sca = StandardScaler().fit(X)
# test data
x1 = np.linspace(-2,3,ng)
x2 = np.linspace(-1,2, ng)
X1,X2 = np.meshgrid(x1,x2)
XX = np.c_[X1.ravel(), X2.ravel()]

# train a SVM model
clf = SVC(C=C, gamma=0.5/sigma).fit(sca.transform(X),y)

# predict on test set
Y_value = clf.decision_function(sca.transform(XX)).reshape([ng,ng])

#show the result
# class boundary
plt.figure(1)
plt.contour(X1, X2, Y_value,[-1,0])
# support vector
supvec=sca.inverse_transform(clf.support_vectors_)
I0 = (clf.dual_coef_ < 0).ravel() # select the data that belongs to class 1
I1 = (clf.dual_coef_ > 0).ravel() # select the data that belongs to class 2

plt.plot(X[y==0,0],X[y==0,1],'C1.',X[y==1,0],X[y==1,1],'C2.')
plt.plot(supvec[I0,0],supvec[I0,1],'C1o',mfc='white')
plt.plot(supvec[I1,0], supvec[I1,1], 'C2o', mfc='white')
plt.xlabel('x1')
plt.ylabel('x2')
# decision function
fig=plt.figure(2)
ax = Axes3D(fig)
ax.plot_surface(X1,X2,Y_value, cmap=plt.cm.coolwarm)
ax.set_xlabel('x1')
ax.set_ylabel('x2')
ax.set_zlabel('f(x)')
plt.show()
