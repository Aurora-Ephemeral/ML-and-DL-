function [netTransfer]=trainAlexNet(imdsTrain,imdsValidation)
%% fine tuning the nerual network of Alexnet
%the same pre processing as others network 
%Attention: image input size is 227 x 227 please change the 02. step in
%transferlearning main function

%fine tuning in Alexnet: 
    % line 61 and line 64: add Bacht Nomalization layer after fourth and fifth convolutional
    % layers 
    % line 37:setting the Max Epoch to 20 because of the Batch normlization
    
    % line 73-75: take place of the last three layer and define the weight
    % line73: initialization in fully connected layer with he fucntion 
%if the result for new testset is not good, please try to use freeze layer
%in the line 79-83 


%% Load Initial Parameters
% Load parameters for network initialization.(The parameters of the initial pretrained network.) 
params = load("parameter\params_alexnet.mat");%load the Alexnet parameter it saves in parameter foler in this current working space

%% Augmentation Settings
pixelRange = [-30 30];
%Configuration of augementation:
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore([227 227 3],imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore([227 227 3], imdsValidation,...
    'DataAugmentation',imageAugmenter);

%% Trainoption
options = trainingOptions('sgdm' , ...
    'MiniBatchSize',8, ...
    'MaxEpochs',20, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',5, ...
    'Verbose',false, ...
    'Plots','training-progress',...
  'ExecutionEnvironment','gpu');

%% Create Layer Graph 
% Create the layer graph variable to contain the network layers.
layers = [
    imageInputLayer([227 227 3],"Name","data","Mean",params.data.Mean)
    convolution2dLayer([11 11],96,"Name","conv1","BiasLearnRateFactor",2,"Stride",[4 4],"Bias",params.conv1.Bias,"Weights",params.conv1.Weights)
    reluLayer("Name","relu1")
    crossChannelNormalizationLayer(5,"Name","norm1","K",1)
    maxPooling2dLayer([3 3],"Name","pool1","Stride",[2 2])
    groupedConvolution2dLayer([5 5],128,2,"Name","conv2","BiasLearnRateFactor",2,"Padding",[2 2 2 2],"Bias",params.conv2.Bias,"Weights",params.conv2.Weights)
    reluLayer("Name","relu2")
    crossChannelNormalizationLayer(5,"Name","norm2","K",1)
    maxPooling2dLayer([3 3],"Name","pool2","Stride",[2 2])
    convolution2dLayer([3 3],384,"Name","conv3","BiasLearnRateFactor",2,"Padding",[1 1 1 1],"Bias",params.conv3.Bias,"Weights",params.conv3.Weights)
    reluLayer("Name","relu3")
    groupedConvolution2dLayer([3 3],192,2,"Name","conv4","BiasLearnRateFactor",2,"Padding",[1 1 1 1],"Bias",params.conv4.Bias,"Weights",params.conv4.Weights)
    batchNormalizationLayer("Name","batchnorm3")
    reluLayer("Name","relu4")
    groupedConvolution2dLayer([3 3],128,2,"Name","conv5","BiasLearnRateFactor",2,"Padding",[1 1 1 1],"Bias",params.conv5.Bias,"Weights",params.conv5.Weights)
    batchNormalizationLayer("Name","batchnorm4")
    reluLayer("Name","relu5")
    maxPooling2dLayer([3 3],"Name","pool5","Stride",[2 2])
    fullyConnectedLayer(4096,"Name","fc6","BiasLearnRateFactor",2,"Bias",params.fc6.Bias,"Weights",params.fc6.Weights)
    reluLayer("Name","relu6")
    dropoutLayer(0.5,"Name","drop6")
    fullyConnectedLayer(4096,"Name","fc7","BiasLearnRateFactor",2,"Bias",params.fc7.Bias,"Weights",params.fc7.Weights)
    reluLayer("Name","relu7")
    dropoutLayer(0.5,"Name","drop7")
    fullyConnectedLayer(10,"Name","new_fc8",'WeightsInitializer','he')% new layer we create, with he's weight initialization 
    softmaxLayer("Name","prob")
    classificationLayer("Name","output")];
lgraph=layerGraph(layers);

%% freeze layers
%layers = lgraph.Layers;
%connections = lgraph.Connections;

%layers(1:9) = freezeWeights(layers(1:9));
%lgraph = createLgraphUsingConnections(layers,connections);

%% Train the network 
netTransfer = trainNetwork(augimdsTrain,lgraph,options);
end


