function [netTransfer]=trainSqueezeNet(imdsTrain,imdsValidation)


%% Squeezenet Trainfer learning main function 
% Script for creating the layers for a deep learning network with the following properties:
%  Number of layers: 69
%  Number of connections: 75
%  Pretrained parameters file: D:\learn\TU Leben\4. Semester\arp\trainingSetup_2020_08_21__21_15_26.mat
%  the same pre processing as others network 
%  Attention: image input size is 227 x 227 

%fine tuning in SqueezeNet:
    % line 42: change the solver to adam (default: sgdm)
    % line 44: change initiallearnrate to 0.0001
    % line 197: add Batch Nomalization layer after the last Relu layer 
    % line 45: setting the Max Epoch to 12 and MiniBatch to 5 because of the Batch normlization
    % line 199 - 200: Replace the last convolutional layer and classification layer and define the weight
    % line 243-247: Freeze the first 10 layer

%% Load Initial Parameters
% Load parameters for network initialization.(The parameters of the initial pretrained network.)
params = load("parameter\params_squeezenet.mat");


%% Augmentation Settings
pixelRange = [-30 30];
scaleRange = [0.9 1.1];

imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange, ...
    'RandXScale',scaleRange, ...
    'RandYScale',scaleRange);

augimdsTrain = augmentedImageDatastore([227 227 3],imdsTrain,"DataAugmentation",imageAugmenter);
augimdsValidation = augmentedImageDatastore([227 227 3],imdsValidation);


%% Set Training Options
% Specify options to use when training.
opts = trainingOptions("adam",...
    "ExecutionEnvironment","gpu",...
    "InitialLearnRate",0.0001,...
    "MaxEpochs",12,...
    "MiniBatchSize",5,...
    "Shuffle","every-epoch",...
    "ValidationFrequency",50,...
    "Plots","training-progress",...
    "ValidationData",augimdsValidation);

%% Create Layer Graph 
% Create the layer graph variable to contain the network layers.
lgraph = layerGraph();

%% Add Layer Branches
% Add the branches of the network to the layer graph. Each branch is a linear array of layers.

tempLayers = [
    imageInputLayer([227 227 3],"Name","data","Mean",params.data.Mean)
    convolution2dLayer([3 3],64,"Name","conv1","Stride",[2 2],"Bias",params.conv1.Bias,"Weights",params.conv1.Weights)
    reluLayer("Name","relu_conv1")
    maxPooling2dLayer([3 3],"Name","pool1","Stride",[2 2])
    convolution2dLayer([1 1],16,"Name","fire2-squeeze1x1","Bias",params.fire2_squeeze1x1.Bias,"Weights",params.fire2_squeeze1x1.Weights)
    reluLayer("Name","fire2-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],64,"Name","fire2-expand1x1","Bias",params.fire2_expand1x1.Bias,"Weights",params.fire2_expand1x1.Weights)
    reluLayer("Name","fire2-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],64,"Name","fire2-expand3x3","Padding",[1 1 1 1],"Bias",params.fire2_expand3x3.Bias,"Weights",params.fire2_expand3x3.Weights)
    reluLayer("Name","fire2-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire2-concat")
    convolution2dLayer([1 1],16,"Name","fire3-squeeze1x1","Bias",params.fire3_squeeze1x1.Bias,"Weights",params.fire3_squeeze1x1.Weights)
    reluLayer("Name","fire3-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],64,"Name","fire3-expand3x3","Padding",[1 1 1 1],"Bias",params.fire3_expand3x3.Bias,"Weights",params.fire3_expand3x3.Weights)
    reluLayer("Name","fire3-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],64,"Name","fire3-expand1x1","Bias",params.fire3_expand1x1.Bias,"Weights",params.fire3_expand1x1.Weights)
    reluLayer("Name","fire3-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire3-concat")
    maxPooling2dLayer([3 3],"Name","pool3","Padding",[0 1 0 1],"Stride",[2 2])
    convolution2dLayer([1 1],32,"Name","fire4-squeeze1x1","Bias",params.fire4_squeeze1x1.Bias,"Weights",params.fire4_squeeze1x1.Weights)
    reluLayer("Name","fire4-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],128,"Name","fire4-expand3x3","Padding",[1 1 1 1],"Bias",params.fire4_expand3x3.Bias,"Weights",params.fire4_expand3x3.Weights)
    reluLayer("Name","fire4-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","fire4-expand1x1","Bias",params.fire4_expand1x1.Bias,"Weights",params.fire4_expand1x1.Weights)
    reluLayer("Name","fire4-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire4-concat")
    convolution2dLayer([1 1],32,"Name","fire5-squeeze1x1","Bias",params.fire5_squeeze1x1.Bias,"Weights",params.fire5_squeeze1x1.Weights)
    reluLayer("Name","fire5-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],128,"Name","fire5-expand1x1","Bias",params.fire5_expand1x1.Bias,"Weights",params.fire5_expand1x1.Weights)
    reluLayer("Name","fire5-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],128,"Name","fire5-expand3x3","Padding",[1 1 1 1],"Bias",params.fire5_expand3x3.Bias,"Weights",params.fire5_expand3x3.Weights)
    reluLayer("Name","fire5-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire5-concat")
    maxPooling2dLayer([3 3],"Name","pool5","Padding",[0 1 0 1],"Stride",[2 2])
    convolution2dLayer([1 1],48,"Name","fire6-squeeze1x1","Bias",params.fire6_squeeze1x1.Bias,"Weights",params.fire6_squeeze1x1.Weights)
    reluLayer("Name","fire6-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],192,"Name","fire6-expand1x1","Bias",params.fire6_expand1x1.Bias,"Weights",params.fire6_expand1x1.Weights)
    reluLayer("Name","fire6-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],192,"Name","fire6-expand3x3","Padding",[1 1 1 1],"Bias",params.fire6_expand3x3.Bias,"Weights",params.fire6_expand3x3.Weights)
    reluLayer("Name","fire6-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire6-concat")
    convolution2dLayer([1 1],48,"Name","fire7-squeeze1x1","Bias",params.fire7_squeeze1x1.Bias,"Weights",params.fire7_squeeze1x1.Weights)
    reluLayer("Name","fire7-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],192,"Name","fire7-expand3x3","Padding",[1 1 1 1],"Bias",params.fire7_expand3x3.Bias,"Weights",params.fire7_expand3x3.Weights)
    reluLayer("Name","fire7-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],192,"Name","fire7-expand1x1","Bias",params.fire7_expand1x1.Bias,"Weights",params.fire7_expand1x1.Weights)
    reluLayer("Name","fire7-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire7-concat")
    convolution2dLayer([1 1],64,"Name","fire8-squeeze1x1","Bias",params.fire8_squeeze1x1.Bias,"Weights",params.fire8_squeeze1x1.Weights)
    reluLayer("Name","fire8-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],256,"Name","fire8-expand1x1","Bias",params.fire8_expand1x1.Bias,"Weights",params.fire8_expand1x1.Weights)
    reluLayer("Name","fire8-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],256,"Name","fire8-expand3x3","Padding",[1 1 1 1],"Bias",params.fire8_expand3x3.Bias,"Weights",params.fire8_expand3x3.Weights)
    reluLayer("Name","fire8-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire8-concat")
    convolution2dLayer([1 1],64,"Name","fire9-squeeze1x1","Bias",params.fire9_squeeze1x1.Bias,"Weights",params.fire9_squeeze1x1.Weights)
    reluLayer("Name","fire9-relu_squeeze1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([1 1],256,"Name","fire9-expand1x1","Bias",params.fire9_expand1x1.Bias,"Weights",params.fire9_expand1x1.Weights)
    reluLayer("Name","fire9-relu_expand1x1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([3 3],256,"Name","fire9-expand3x3","Padding",[1 1 1 1],"Bias",params.fire9_expand3x3.Bias,"Weights",params.fire9_expand3x3.Weights)
    reluLayer("Name","fire9-relu_expand3x3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","fire9-concat")
    dropoutLayer(0.5,"Name","drop9")
    convolution2dLayer([1 1],10,"Name","conv","Padding","same")
    reluLayer("Name","relu_conv10")
    batchNormalizationLayer("Name","batchnorm")
    globalAveragePooling2dLayer("Name","pool10")
    softmaxLayer("Name","prob")
    classificationLayer("Name","classoutput")];
lgraph = addLayers(lgraph,tempLayers);

% clean up helper variable
clear tempLayers;

%% Connect Layer Branches
% Connect all the branches of the network to create the network graph.

lgraph = connectLayers(lgraph,"fire2-relu_squeeze1x1","fire2-expand1x1");
lgraph = connectLayers(lgraph,"fire2-relu_squeeze1x1","fire2-expand3x3");
lgraph = connectLayers(lgraph,"fire2-relu_expand1x1","fire2-concat/in1");
lgraph = connectLayers(lgraph,"fire2-relu_expand3x3","fire2-concat/in2");
lgraph = connectLayers(lgraph,"fire3-relu_squeeze1x1","fire3-expand3x3");
lgraph = connectLayers(lgraph,"fire3-relu_squeeze1x1","fire3-expand1x1");
lgraph = connectLayers(lgraph,"fire3-relu_expand1x1","fire3-concat/in1");
lgraph = connectLayers(lgraph,"fire3-relu_expand3x3","fire3-concat/in2");
lgraph = connectLayers(lgraph,"fire4-relu_squeeze1x1","fire4-expand3x3");
lgraph = connectLayers(lgraph,"fire4-relu_squeeze1x1","fire4-expand1x1");
lgraph = connectLayers(lgraph,"fire4-relu_expand3x3","fire4-concat/in2");
lgraph = connectLayers(lgraph,"fire4-relu_expand1x1","fire4-concat/in1");
lgraph = connectLayers(lgraph,"fire5-relu_squeeze1x1","fire5-expand1x1");
lgraph = connectLayers(lgraph,"fire5-relu_squeeze1x1","fire5-expand3x3");
lgraph = connectLayers(lgraph,"fire5-relu_expand1x1","fire5-concat/in1");
lgraph = connectLayers(lgraph,"fire5-relu_expand3x3","fire5-concat/in2");
lgraph = connectLayers(lgraph,"fire6-relu_squeeze1x1","fire6-expand1x1");
lgraph = connectLayers(lgraph,"fire6-relu_squeeze1x1","fire6-expand3x3");
lgraph = connectLayers(lgraph,"fire6-relu_expand3x3","fire6-concat/in2");
lgraph = connectLayers(lgraph,"fire6-relu_expand1x1","fire6-concat/in1");
lgraph = connectLayers(lgraph,"fire7-relu_squeeze1x1","fire7-expand3x3");
lgraph = connectLayers(lgraph,"fire7-relu_squeeze1x1","fire7-expand1x1");
lgraph = connectLayers(lgraph,"fire7-relu_expand1x1","fire7-concat/in1");
lgraph = connectLayers(lgraph,"fire7-relu_expand3x3","fire7-concat/in2");
lgraph = connectLayers(lgraph,"fire8-relu_squeeze1x1","fire8-expand1x1");
lgraph = connectLayers(lgraph,"fire8-relu_squeeze1x1","fire8-expand3x3");
lgraph = connectLayers(lgraph,"fire8-relu_expand3x3","fire8-concat/in2");
lgraph = connectLayers(lgraph,"fire8-relu_expand1x1","fire8-concat/in1");
lgraph = connectLayers(lgraph,"fire9-relu_squeeze1x1","fire9-expand1x1");
lgraph = connectLayers(lgraph,"fire9-relu_squeeze1x1","fire9-expand3x3");
lgraph = connectLayers(lgraph,"fire9-relu_expand3x3","fire9-concat/in2");
lgraph = connectLayers(lgraph,"fire9-relu_expand1x1","fire9-concat/in1");

%% freeze layers
layers = lgraph.Layers;
connections = lgraph.Connections;

layers(1:10) = freezeWeights(layers(1:10));
lgraph = createLgraphUsingConnections(layers,connections);

%% Train networks
% Train the network using the specified options and training data.

netTransfer = trainNetwork(augimdsTrain,lgraph,opts);
end
