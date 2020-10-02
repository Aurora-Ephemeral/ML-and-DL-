function[feature4test]= Predictpls(PreprocessdeNIRtest,v_pls)
%% dimension reduction application in test set
%input:
    %input matrix shoubl be nx224 without label and pre-processed
    %vector calculated by pls function yon can also load the vector in curruent
    %folder called 'plsvector.mat'
 
%output
    % reduced feature for prediction by svm classifier
%% transform the dimension: 
feature4test=PreprocessdeNIRtest*v_pls.W;
fprintf('[status]:feature extraction for test completed \n');
end