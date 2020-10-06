function [feature4autoencoder,sae_net]=sae(processedNIR,hiddenSize)
%% feature extraction by autoencoder 
[n,m]=size(processedNIR);
feature=processedNIR(:,1:m-1);
label=processedNIR(:,m);
feature=feature';
%% train the autoencoder network 
sae_net=trainAutoencoder(feature,hiddenSize,'MaxEpochs',400);
%evalueate the result: 
feature_Re=predict(sae_net,feature);
mesErro=mse(feature-feature_Re);
fprintf('the mean suquared error is: %f\n',mesErro);
%generate the reconstructed feature 
featurerecon=encode(sae_net,feature);
feature4autoencoder=[featurerecon',label];
save('autoencoder.mat','sae_net');
save('autoencoder4training.mat','feature4autoencoder'); 
fprintf('[status]:feature extraction completed \n');
end