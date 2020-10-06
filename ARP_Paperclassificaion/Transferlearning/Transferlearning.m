%% main function for Transferlearning 

% In the folder result contains the dataset, model and confusion matrix 
% in this project. You can use dataset directly by move them to the current 
% workingspace or yon can follow this code it will automaitcally generat
% the same folder in your computer. 

%01.extract the image and compress into required size: 
    % this function will automatically create two folders called '224x224'
    % and '227x227' at curruent folder, which is the size of image.
    % Attention: It is enough that this function only executed once. If you 
    % already have compressed image please ignore this function because it
    % takes a while.
    % method 2 and 3 is aimed for comparing different rescaling method. 
    % method 2 rescale the image directly with setting background to 0. 
    % method 3 rescale the image direclty without setting background to 0.
    % please pay attention to the same name among three methods 
    
%02.split the data into train, validation and test 
    %in order to get good result presentation you should rename the class
    %from 01 to 10 
    %default save path: curruent working space: testpic contains total 500
    %objects and 224 and 227 is image size 
    %trainpic contains total 3500 objects and 224 and 227 is image size
    %Attention: this function normally using once is enough 
    
%03.fine tuning a pre trained network
    %different network has different hyperparameter, the parameter is in
    %parameter folder in this curruent working space
    %Attention: different network require different input size. Please use
    %the image with correct size as input for example in this template,
    %224x224 for resnet 18
    %if neccessary, pleas save the netTransfer for futher work
%04/05.test and evaluate on the test set
    %important indicator: accuracy, speed and confusion matrix 

%% define the parameter 
picpath='D:\Master_Maschinenbau\ARP\_Dataset2'; % define the the whole dataset in this template data set with 4000 objects
%% 01 extract image and compress the image into required size 224 x 224 & 227 x 227
[newpath227,newpath224]=resizeimage(picpath);%imagepreprocessing method 1(gives the best result)
%[newpath227,newpath224]=resizeimage2(picpath);%imagepreprocessing method 2
%[newpath227,newpath224]=resizeimage3(picpath);%imagepreprocessing method 3
%% 02 split the data into train, validation and test 
%[imdsTrain,imdsValidation,imdsTest]=imgsplit(newpath224,224);% for Resnet VGG GoogLeNet please use this command
[imdsTrain,imdsValidation,imdsTest]=imgsplit(newpath227,227);% for Alexnet and Squeezenet please use this command

%% 03 train a network 
%[netTransfer]=trainResNet18(imdsTrain,imdsValidation); % for ResNet18
%[netTransfer]=trainvgg16(imdsTrain,imdsValidation); %for vgg16 
%[netTransfer]=trainAlexNet(imdsTrain,imdsValidation); % for Alexnet
[netTransfer]=trainSqueezeNet(imdsTrain,imdsValidation); %for Squeenzenet
%[netTransfer] = trainGoogLeNet(imdsTrain,imdsValidation); % for GoogLeNet
%% 04 Predict in the test set 
[YPred,YTest]=testnetwork(imdsTest,netTransfer);%prediction for Alexnet, Squeezenet, GoogLeNet and Resnet18
%[YPred,YTest]=testvgg16(imdsTest,netTransfer,500);%speicific method for vgg16 net 

%% 05 Evaluation and show the result 
evaluate(YPred,YTest);
