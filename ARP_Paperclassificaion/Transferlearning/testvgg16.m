function [YPredcat,YTest]=testvgg16(imdsTest,netTransfer,testsize)
%% evalutate trained model of transferlearning 
%parituclar test function for vgg16 because of the limitation of gpu device
%in our computer
%instead of prediction of 500 objects in array format here we use for
%recycling
%if the gpu is powerful, you can also use "testnetwork" function, where the
%test set is storaged in array format. 
%Recommend: using the testnetwork primarily, if the gpu allows, beacause
%array format is much faster than for recycling in computing. 
%% code 
tic;
for i=1:testsize
location=imdsTest.Files(i,1);
imds=imageDatastore(location);    
%%apply on test data and calculate the running time
YPred{i,1}=classify(netTransfer,imds); 
end
toc;
%Evaluation
YTest=imdsTest.Labels;
YPredcat=[];
%transfer the cell into array format: 
for i=1:testsize 
Ynew=YPred{i,1};
YPredcat=[YPredcat;Ynew];
end

fprintf('[status]: Prediction complete\n');
end