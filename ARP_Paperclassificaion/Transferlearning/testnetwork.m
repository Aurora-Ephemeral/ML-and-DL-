function [YPred,YTest]=testnetwork(imdsTest,network)
tic;
YPred=classify(network,imdsTest); 
toc;
%Evaluation
YTest=imdsTest.Labels;
fprintf('[status]: Prediction complete\n');
end