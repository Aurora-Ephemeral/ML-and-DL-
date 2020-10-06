import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.datasets import load_iris
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import confusion_matrix, plot_confusion_matrix

# load data

k = 11
ng = 51
iris = load_iris()
I = (iris.target == 1) | (iris.target == 2)
X = iris.data[I,2:4]
y = iris.target[I]
scalingdata = StandardScaler().fit(X)

# Test data preparation

x1 = np.linspace(3,7,ng)
x2 = np.linspace(0.9,2.6,ng)
X1, X2 = np.meshgrid(x1,x2)
XX = np.c_[X1.ravel() , X2.ravel()]

# Train Classifier

classifier = KNeighborsClassifier(n_neighbors=k)
classifier.fit(scalingdata.transform(X),y)
Prob = classifier.predict_proba(scalingdata.transform(XX))
Y_pred = classifier.predict(scalingdata.transform(X))
Prob = Prob.reshape(ng,ng,-1)

# show the class boundary of the training result

plot_confusion_matrix(classifier,scalingdata.transform(X),y)


# show the boundary in training set

plt.figure(2)
plt.contour(X1, X2, Prob[:,:,0], [0.5])
plt.plot(X[y==1,0], X[y==1,1], 'r+', X[y==2,0], X[y==2,1],'bo')
plt.xlabel('$feature_1$')
plt.ylabel('$feature_2$')
plt.title('k = ' + str(k))

# show the graphic of Decision function

ax = Axes3D(plt.figure(3))
ax.plot_surface(X1, X2, Prob[:, :, 0], cmap=plt.cm.coolwarm)
ax.set_xlabel('$feature 1$')
ax.set_ylabel('$feature 2$')
ax.set_zlabel('$Probability$')

plt.show()

