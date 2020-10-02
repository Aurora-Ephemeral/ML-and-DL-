function [PreprocessdeNIRtest,Reponse]=Predictldapreprocess(NIRtest,meanvalue,stdvalue,lowerwavelength,upperwavelength)
%% processing the test set 
% the same working flow as ldapreprocess 
% using the exsisted meanvalue and stdvalue SNV along cloumn direction 

%% extract the feature and reponse
[n,m]=size(NIRtest);
Reponse=NIRtest(:,m);
feature2=NIRtest(:,1:m-1);
%% offset correction and crop spectrum into ROI 
for i = 1:n
    offset=mean(feature2(i,1:10));
    vector(1,1:224)=offset;
    feature2(i,:)=feature2(i,:)-vector;
    feature(i,:)=feature2(i,lowerwavelength:upperwavelength);
end

%% SNV along column's direction 
PreprocessdeNIRtest= (feature-meanvalue)./stdvalue;
fprintf('[status]:pre process for test set completed \n');
end

