%% variable defition
trainpathlocation ='D:\Master_Maschinenbau\ARP\Paperset\Trainset'; % the path to the storage of training set
trainobjectsize = 3500; % optional, just save the time of allocating the RAM
testpathlocation ='D:\Master_Maschinenbau\ARP\Paperset\Testset'; % the path to the storage of test set
testobjectsize = 500;% optional, just save the time of allocating the RAM

lowerwavelength=10;% define the range of interest
upperwavelength=210;% define the range of interest
hiddenSize=10;% if use autoencoder method please define the number of neurons in hidden layer 

%% trainset extract
trainImgfeature = extractImgfeature(trainpathlocation,trainobjectsize);
trainMechanicalfeature = extractMechanicalfeature(trainpathlocation,trainobjectsize);
trainLabel = extractLabel(trainpathlocation,trainobjectsize);
NIRtrain=takeNIRspectrum(trainpathlocation,trainobjectsize);
%% combine the NIR with label 
NIRtrainwithlabel =[NIRtrain,trainLabel];
%% excute NIR preprocess
[processedNIRtrain,meanvalue,stdvalue]=plspreprocess(NIRtrainwithlabel,lowerwavelength,upperwavelength);%pls

%alternative:
%[processedNIRtrain,meanvalue,stdvalue]=pcapreprocess(NIRtrainwithlabel,lowerwavelength,upperwavelength);%pca
%[processedNIRtrain,meanvalue,stdvalue]=saepreprocess(NIRtrainwithlabel,lowerwavelength,upperwavelength);%autoencoder
%[processedNIRtrain,meanvalue,stdvalue]=ldapreprocess(NIRtrainwithlabel,lowerwavelength,upperwavelength);%lda

%% NIR demensionreduction
[feature4train,v_pls]=pls(processedNIRtrain);

%alternative: 
%[feature4train,v_pca]=pca(processedNIRtrain); %pca
%[feature4train,sae_net]=sae(processedNIRtrain,hiddenSize); %autoencoder
%[feature4train,v_lda]= lda(processedNIRtrain); %lda 
%% split the label

[n,m] = size(feature4train);% get the size of the matrix, and the last column is label
% take it without label
trainNIRfeature = feature4train(:,1:(m-1));

%% combine to a full feature matrix
totrain =[trainImgfeature,trainNIRfeature,trainMechanicalfeature,trainLabel];
%% train SVM
[classificationSVM,validationAccuracy]=svmMachine(totrain);
%% test set take from .mat
testImgfeature = extractImgfeature(testpathlocation,testobjectsize);%image feature
testMechanicalfeature = extractMechanicalfeature(testpathlocation,testobjectsize);% mechanical sensor feature
testLabel = extractLabel(testpathlocation,testobjectsize);%label
NIRtest=takeNIRspectrum(testpathlocation,testobjectsize);%NIR spectrum 
%% testset NIR standardlization
PreprocessdeNIRtest=Predictplspreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%pls

%alternative: 
%PreprocessdeNIRtest=Predictsaepreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%autoencoder
%PreprocessdeNIRtest=Predictpcapreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%pca
%PreprocessdeNIRtest=Predictldapreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength);%lda


%% Dimension Reduction for test data 
[NIRfeature4test]= Predictpls(PreprocessdeNIRtest,v_pls);%pls

%alternative: 
%[NIRfeature4test]= Predictsae(PreprocessdeNIRtest,sae_net);%autoencoder
%[NIRfeature4test]= Predictlda(PreprocessdeNIRtest,v_lda);%lda
%[NIRfeature4test]= Predictpca(PreprocessdeNIRtest,v_pca);%pca
%% combination of data
totest =[testImgfeature,NIRfeature4test,testMechanicalfeature];

%% prediciton
Ypredict=predict(classificationSVM,totest);
%% show the matrix
accuracy = checkAndPlot(testLabel,Ypredict);



