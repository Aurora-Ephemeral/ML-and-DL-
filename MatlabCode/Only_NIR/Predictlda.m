function[feature4test]= Predictlda(PreprocessdeNIRtest,v_lda)
%% dimension reduction application in test set
%input:
    %input matrix shoubl be nx224 without label and pre-processed
    %vector calculated by lda function yon can also load the vector in curruent
    %folder called 'ldavector.mat'
 
%output
    % reduced feature for prediction by svm classifier
%% transform the dimension: 
feature4test=PreprocessdeNIRtest*v_lda;
fprintf('[status]:feature extraction for test completed \n');
end