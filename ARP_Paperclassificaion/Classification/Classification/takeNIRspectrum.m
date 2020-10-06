function [NIRspectrum]=takeNIRspectrum(location,objectnumber)
%% extract the NIR spectrum from oringinal dataset
% this file is used to extract the nir data(hcam) from the complete dataset
% it should be used after split the train set and test set totally
% Oringinal dataset in this code is "_Dataset2"
% each class has 350 objects for training

%input:
% *trainsetpath*: storage path for training set for example: 
% For exsample:trainsetpath='D:\Master_Maschinenbau\ARP\Paperset\Trainset2\'; 
% *classsize*: the number of object in each class for training for example: 350

%output:
%
% If you want, you can save the parameter "nirtrain" as nirtrain.mat in 
% workspace in the desired path in your computer 
% If you already have NIR dataset, just ignore this file
%% code

NIRspectrum=zeros(objectnumber,224);%storage the extracted NIR spectrum
parfor picnum =1:objectnumber    
data =load(location+"\"+num2str(picnum)+".mat");
 % NIR spectrum get
 NIRspectrum(picnum,:)=data.data.hcam; 
end
fprintf('-------NIR extraction completed--------\n');
end