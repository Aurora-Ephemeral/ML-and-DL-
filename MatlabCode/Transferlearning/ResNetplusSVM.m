%% combine the Deep learning and Machine learning 
% deep learning as Feature Extractor and machine learning as feature
% classifier 
% deep learning part: ResNet 18 
% machine learning part: SVM 
% activation layer: pool5 
%% import the train and test data 
clear; 
clc;
imdsTrain=imageDatastore('trainpic224\','IncludeSubfolders',true, ...
    'LabelSource','foldernames');
imdsTest=imageDatastore('testpic224\','IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%% import pre trained network 
load('model\resnetmodify.mat');
net = netTransfer;

%% Augumentaion of image
inputSize = net.Layers(1).InputSize;
pixelRange = [-30 30];
%Configuration of augementation:
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest, ...
    'DataAugmentation',imageAugmenter);

%% Image Feature Extraction 
layer = 'pool5'; 
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');

%% train machine learning classifier 
% extract label 
YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;
% define classifier: SVM in 2 order  
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);

%fit the image classifier 
classifier = fitcecoc(featuresTrain,YTrain,...
    'Learners',template,...
    'coding','onevsone');
%calculate cross validation accuracy 
partitionedModel = crossval(classifier, 'KFold', 10);
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
fprintf('the validation accuracy is %f:\n',validationAccuracy);
%% application in Test dataset
tic;
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');
%featuresTest = activations(net,augimdsTest,layer);
%featuresTest = squeeze(mean(featuresTest,[1 2]))';
YPred = predict(classifier,featuresTest);
toc;
%% result and confusion matrix
%accuracy
accuracy=mean(YTest==YPred);
fprintf('the test accuracy is %f\n',accuracy);
%show the confusion matrix
figure('Units','normalized','Position',[0.2 0.2 0.4 0.4]);
cm = confusionchart(YTest,YPred);
cm.Title = 'Confusion Matrix for Test Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
ylabel('Observation');
xlabel('Prediction');
set(gca,'FontSize',36,'Fontname', 'Times New Roman');