# demo for influence of regression coefficient on cost function

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

nd = 51
ng = 16
f = 0.5
np.random.seed(0)

x = np.linspace(0, 5, nd).reshape(-1, 1)
X = np.hstack((x ** 0, x ** 1))
w = np.ones((X.shape[1], 1))

ys = X @ w
y = ys + f * np.random.randn(*ys.shape)

plt.figure(1)
plt.plot(x, y, 'C1.', x, ys, 'C2-')
plt.xlabel('input')
plt.ylabel('output')

# analysis the influence of different weight

w0 = np.linspace(-3,5, ng)
w1 = np.linspace(0,2,ng)
W0, W1 = np.meshgrid(w0, w1)
W = np.c_[W0.ravel(),W1.ravel()]

J = [np.linalg.norm(y-(X @ ws.reshape(-1,1))) for ws in W]
J = np.array(J)
J = J.reshape((ng,ng))
print(W[1,:].T)


#J = np.zeros(W0.shape)
#for i in range(ng):
#    for j in range(ng):
#        J[i,j] = np.linalg.norm(y-x*W1[i,j]-W0[i,j])

fig = plt.figure(1)
ax = Axes3D(fig)
ax.plot_surface(W0, W1, J, cmap=plt.cm.coolwarm)

