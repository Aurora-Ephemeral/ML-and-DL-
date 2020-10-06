function [processedNIR,meanvalue,stdvalue]=ldapreprocess(NIRtrain,lowerwavelength,upperwavelength)
%% specific pre process for lda method 
% pre process only for lda method 
%
% input: 
%   *NIRspectrumoringinal*: NIR spectrum in matrix form, which each row represents
%   object and each column represents wavelength
%   *upperwavelength,lowerwavelength*: select the ROI 
%
% inputsize: 
%   *NIRspectrum*: n x 225 where n represents the number of objects and 225
%   reprensents 224 wavelength plus 1 label
%
% output: 
%   *processedNIR*: NIR spectrum with label
%   *meanvalue,stdvalue*: for processing the test data necessary


%% extract the feature and reponse
[n,m]= size(NIRtrain);
feature2 = NIRtrain(:,1:m-1);
label = NIRtrain(:,m);
%% offset correction and Select ROI 
for i = 1:n
    offset=mean(feature2(i,1:10));
    vector(1,1:224)=offset;
    feature2(i,:)=feature2(i,:)-vector;
    feature(i,:)=feature2(i,lowerwavelength:upperwavelength);
end

%% SNV along column's direction 
meanvalue = mean (feature);
stdvalue =std(feature);
feature = (feature-meanvalue)./stdvalue;

%% build the new spectrum: 
processedNIR=[feature,label];
fprintf('[status]:lda pre process completed\n');

end