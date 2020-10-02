function [processedNIR,meanvalue,stdvalue]=pcapreprocess(NIRspectrum,lowerwavelength,upperwavelength)
%% common NIR pre processing 
% pre process for pca pls and autoencoder method 
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
%output: 
%   *processedNIR*: NIR spectrum with label
%   *meanvalue,stdvalue*: for processing the test data necessary
%% SNV along row's direction 
[n,m]=size(NIRspectrum);
feature = NIRspectrum(:,1:m-1);
label = NIRspectrum(:,m);
feature=zscore(feature,0,2);

%% SG fitler in firts derivative 
derivate=1;
order=3;
window=11;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
end
 
%% Select ROI 
feature = feature(:,lowerwavelength:upperwavelength);

%% SNV along column's direction 
meanvalue = mean (feature);
stdvalue =std(feature);
feature = (feature-meanvalue)./stdvalue;

%% build the new spectrum: 
processedNIR=[feature,label];
fprintf('-------pca pre process completed--------\n');
end