function [netTransfer]=trainvgg16(imdsTrain,imdsValidation)
%% transferlearning for VGG 16 
% process of vgg is different to other network: before running the code,
% please load the vgg 16 network from Deep Network Designer
% similar processing to alexnet, squeeznet and resnet 
% pay attention to the different input size to Alexnet here 224 
% 
% Fine tuning in vgg16: 
    %line 32-33: reduce the minibatch size and max Epoch
    %line 39: add weight decay regularization in order to avoid overfitting
    %line 45-54: replace the last three layers and use he intializer  
    %line 57-61: freeze the first 6 layers 

%% Load Initial Parameters 
net=vgg16;
inputSize = net.Layers(1).InputSize;

%% Augmentation Settings
pixelRange = [-30 30];
%Configuration of augementation:
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore(inputSize(1:2), imdsValidation,...
    'DataAugmentation',imageAugmenter);
%% Trainoption 
 options = trainingOptions('sgdm' , ...
    'MiniBatchSize',8, ...%reduce the minibatch size to 8 
    'MaxEpochs',6, ... %reduce the max epochs to 6
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',5, ...
    'Verbose',false, ...
    'Plots','training-progress',...
    'L2Regularization',0.0005,...% set weight decay 
  'ExecutionEnvironment','gpu');


%% replace the last three layer of network
%get the number of classes
numClasses = numel(categories(imdsTrain.Labels));
lgraph = layerGraph(net.Layers);
%create new layer
newFCLayer = fullyConnectedLayer(numClasses,'Name','new_fc','WeightsInitializer','he',...% he's weight initialization 
'WeightLearnRateFactor',10,'BiasLearnRateFactor',10);
lgraph = replaceLayer(lgraph,'fc8',newFCLayer);%replace the layer 
newSoftmax=softmaxLayer('name','newsoftmax');
lgraph = replaceLayer(lgraph,'prob',newSoftmax);
newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'output',newClassLayer);

%% freeze the inital 6 layers 
layers = lgraph.Layers;
connections = lgraph.Connections;% get the way how to connect the diiferent layers

layers(1:6) = freezeWeights(layers(1:6));% freeze the first 6 layers 
lgraph = createLgraphUsingConnections(layers,connections); %connect the other layer in the same way 

%% train the network 
netTransfer = trainNetwork(augimdsTrain,lgraph,options);
fprintf('[status]: Fine tuning complete\n');

end