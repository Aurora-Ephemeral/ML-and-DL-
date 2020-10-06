function[feature4test]= Predictpca(PreprocessdeNIRtest,v_pca)
%%
%input matrix shoubl be nx224 without label 
%% transform the dimension: 
feature4test=PreprocessdeNIRtest*v_pca;
fprintf('[status]:feature extraction for test completed \n');
end