function[feature4test]= Predictsae(PreprocessdeNIRtest,network)
%%
%input matrix shoubl be nx224 without label 
%% input into network: 
featuresae=PreprocessdeNIRtest';
featuresae=encode(network,featuresae);
feature4test=featuresae';
fprintf('[status]:feature extraction for test completed \n');
end