function [netTransfer] = trainGoogLeNet(imdsTrain,imdsValidation)
%% transferlearning for GoogLeNet 
% similar processing to alexnet, squeeznet and resnet 
% pay attention to the different input size to Alexnet here 224 

% Fine tuning in GoogLeNet: 
    %line 30-31: reduce the minibatch size and max Epoch

    %line 40-49: replace the last three layers and use he intializer  
    
%if the result for new testset is not good, please try to use freeze layer
%in the line 51-54
 
%% Load Initial Parameters 
net = googlenet;
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
options = trainingOptions('adam',...
 'MiniBatchSize',20,...
 'MaxEpochs',10,...
 'Shuffle','every-epoch',...
 'ValidationData',augimdsValidation,...
 'InitialLearnRate',1e-4,...
 'ValidationFrequency',5,....
 'Verbose',false,...
 'ExecutionEnvironment','gpu',...
'Plots','training-progress');
%% replace the last three layer of network
lgraph = layerGraph(net);
lgraph = removeLayers(lgraph,{'loss3-classifier','prob','output'});%remove old layers
numClasses = numel(categories(imdsTrain.Labels));%get the number of classes
%create new layers
newLayers = [
fullyConnectedLayer(numClasses,'Name','fc','WeightsInitializer','he','weightLearnRateFactor',10,'BiasLearnRateFactor',10)% he's weight initialization 
softmaxLayer('Name','softmax')
classificationLayer('Name','classoutput')];
lgraph = addLayers(lgraph,newLayers);
lgraph = connectLayers(lgraph,'pool5-drop_7x7_s1','fc');% connect the whole layers
%% freeze the inital 10 layers 
%layers = lgraph.Layers;
%connections = lgraph.Connections;% get the way how to connect the diiferent layers
%layers(1:10) = freezeWeights(layers(1:10));% freeze the first 10 layers 
%lgraph = createLgraphUsingConnections(layers,connections); %connect the other layer in the same way 
%% train the network 
netTransfer = trainNetwork(augimdsTrain,lgraph,options);
fprintf('[status]: Fine tuning complete\n');
end
