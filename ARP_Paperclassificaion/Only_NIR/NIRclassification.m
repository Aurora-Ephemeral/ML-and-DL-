%% NIR processing for paper classification 
% please change the rootpath of train set and test set according to yours
% just like this template shows 

%% define the parameter 
trainsetpath='D:\Master_Maschinenbau\ARP\Paperset\Trainset';%input the location of the training  data set in this code 3500 objects 
testsetpath='D:\Master_Maschinenbau\ARP\Paperset\Testset';%input the location of the training  data set in this code 500 objects
trainsetclasssize=350;% input the number of the objects for training in each class
testsetclasssize=50;% input the number of the objects in each class
lowerwavelength=10;
upperwavelength=210;% define the ROI
hiddenSize=10;% if use autoencoder method please define the number of neurons in hidden layer 
%% take the NIR spectrum from the total data set individually 
[NIRtrain]=takeNIRspectrum(trainsetpath,trainsetclasssize);

%% excute NIR preprocess
[processedNIRtrain,meanvalue,stdvalue]=plspreprocess(NIRtrain,lowerwavelength,upperwavelength);%pls

%alternative:
%[processedNIRtrain,meanvalue,stdvalue]=pcapreprocess(NIRtrain,lowerwavelength,upperwavelength);%pca
%[processedNIRtrain,meanvalue,stdvalue]=saepreprocess(NIRtrain,lowerwavelength,upperwavelength);%autoencoder
%[processedNIRtrain,meanvalue,stdvalue]=ldapreprocess(NIRtrain,lowerwavelength,upperwavelength);%lda

%% Dimension Reduction 
[feature4train,v_pls]=pls(processedNIRtrain);%pls

%alternative: 
%[feature4train,v_pca]=pca(processedNIRtrain); %pca
%[feature4train,sae_net]=sae(processedNIRtrain,hiddenSize); %autoencoder
%[feature4train,v_lda]= lda(processedNIRtrain); %lda 

%% train the model 
[svmNIR,validationAccuracy] = svmMachine(feature4train);%svm with polynomial in second order, 10 fold cross validation 

%% take out the test data
[NIRtest]=takeNIRspectrum(testsetpath,testsetclasssize);

%% pre processing the test data
[PreprocessdeNIRtest,Response]=Predictplspreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%pls

%alternative: 
%[PreprocessdeNIRtest,Response]=Predictsaepreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%autoencoder
%[PreprocessdeNIRtest,Response]=Predictpcapreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%pca
%[PreprocessdeNIRtest,Response]=Predictldapreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%lda

%% Dimension Reduction for test data 
[feature4test]= Predictpls(PreprocessdeNIRtest,v_pls);%pls

%alternative: 
%[feature4test]= Predictsae(PreprocessdeNIRtest,sae_net);%autoencoder
%[feature4test]= Predictlda(PreprocessdeNIRtest,v_lda);%lda
%[feature4test]= Predictpca(PreprocessdeNIRtest,v_pca);%pca

%% Predict the testdata 
Ypredict=predict(svmNIR,feature4test);

%% Evaluation: 
evaluate(Ypredict,Response);
