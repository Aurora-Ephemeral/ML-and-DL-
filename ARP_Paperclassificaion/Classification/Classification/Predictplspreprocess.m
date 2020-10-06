function [PreprocessdeNIRtest]=Predictplspreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength)
%%

%% get the input

feature=NIRtest;
%% strandarlization according to each row 
feature=zscore(feature,0,2);
%% SG Filte in 1.Derivate 
derivate=1;
order=3;
window=11;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
end
%% Crop the spectrum into ROI
feature=feature(:,lowerwavelength:upperwavelength);

%% standardlization according to each colum 
PreprocessdeNIRtest= (feature-meanvalue)./stdvalue;
fprintf('-------pre process for test set completed--------\n');

end