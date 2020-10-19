'LDA Feature Reduction from original data set'
__author__ = 'Aurora'

import scipy.io as scio
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score, plot_confusion_matrix
from sklearn import svm

lowerwavelength = 10
upperwavelength =210
wavelength = upperwavelength - lowerwavelength+1
path = "D:/Master_Maschinenbau/ARP/python_version/NIR/data3500.mat"
data = scio.loadmat(path)
data = data['nirtrain']
Trainspec2 = data[:,0:224]
Label = data[:,224]
n,m = Trainspec2.shape
Trainspec = np.zeros(shape=(n,wavelength))
# offset correction
for i in range(n):
    offset = np.mean(Trainspec2[i,1:10])
    Trainspec2[i,:] = np.array(Trainspec2[i,:]) - offset
    Trainspec[i,:] = Trainspec2[i,9:210]
# SNV
sca = StandardScaler().fit(Trainspec)
Feature = sca.transform(Trainspec)

# Feature Reduction: LDA
np.set_printoptions(precision=4)
classmean =[]
#calculate the mean value of each class
for y in range(1,11):
    classmean.append(np.mean(Feature[Label == y], axis=0))
# within matrix
d = classmean[0].size
S_W = np.zeros((d,d))
for y, mv in zip(range(1,11), classmean):
    class_scatter = np.zeros((d,d))
    for row in Feature[Label == y]:
        row, mv = row.reshape(d,1), mv.reshape(d,1)
        class_scatter +=(row -mv).dot((row-mv).T)
    S_W+=class_scatter
# between matrix
mean_overall = np.mean(Feature, axis=0)
S_B = np.zeros(shape=(d,d))
for i, mean_vec in  enumerate(classmean):
    n = Feature[Label == i+1, :].shape[0]
    mean_vec = mean_vec.reshape(d,1)
    mean_overall = mean_overall.reshape(d,1)
    S_B += n *(mean_vec-mean_overall).dot((mean_vec-mean_overall).T)
# eigenvalue calculation
eigen_vals, eigen_vecs = np.linalg.eig(np.linalg.inv(S_W).dot(S_B))
# show the reduction result
tot = sum(eigen_vals.real)
ratio = [x/tot for x in sorted(eigen_vals.real, reverse=True)]
cumsum_ratio = np.cumsum(ratio)
plt.figure(1)
plt.plot(range(eigen_vals.shape[0]),cumsum_ratio,'C1o-')
plt.ylabel('Percentage of the main component')
plt.xlabel('number of eigenvalue')

eigen_pairs = [(np.abs(eigen_vals[i]),eigen_vecs[:,i]) for i in range(len(eigen_vals))]
eigen_pairs = sorted(eigen_pairs, key=lambda x:x[0],reverse=True)
num = input("plase select the number of the main component:")

#create the selected redution transformation matrix:
W= np.zeros(shape=(201,int(num)))
for i in range(int(num)):
    W_z = eigen_pairs[i][1][:,np.newaxis].real.reshape(201)
    W[:,i]= W_z
Feature_lda = Feature.dot(W)

#show the reduced feature

plt.figure(2)
col = ['r','g','b','c','y','m','k','orange','grey','hotpink']
for l,c in zip(np.unique(Label),col):
    plt.scatter(Feature_lda[Label == l, 0],Feature_lda[Label == l, 1], marker='o',c=c,label=l)
    plt.xlabel('LD1')
    plt.ylabel('LD2')
    plt.legend(loc='lower right')

# trainSVM model
clf = svm.SVC(decision_function_shape='ovo', kernel= 'poly',degree=2,probability=True).fit(Feature_lda,Label)
Y_pred = clf.predict(Feature_lda)
accuracy = accuracy_score(Label, Y_pred)
print('the total accuracy of the training set is %f' % accuracy)

# evaluate the model in test set:

pathtest = 'D:/Master_Maschinenbau/ARP/python_version/NIR/data500.mat'
datat = scio.loadmat(pathtest)
datat = datat['nirtest']
Testspec2 = datat[:,0:224]
Labelt = datat[:,224]
n,m = Testspec2.shape
Testspec = np.zeros(shape=(n,wavelength))
for i in range(n):
    offset = np.mean(Testspec2[i,1:10])
    Testspec2[i,:] = np.array(Testspec2[i,:]) - offset
    Testspec[i,:] = Testspec2[i,9:210]
Featuret = sca.transform(Testspec)
Featuret_lda = Featuret.dot(W)
Yt_Pred = clf.predict(Featuret_lda)
test_accuracy = accuracy_score(Labelt, Yt_Pred)

#show the confusion matrix

plt.figure(3)
plot_confusion_matrix(clf, Featuret_lda, Labelt, cmap=plt.cm.Blues,normalize='true')
print('the accuracy on test set is: %f' %test_accuracy)


