function [feature4pls,v_pls]=pls(processedNIR) 
[n,m]=size(processedNIR);
feature=processedNIR(:,1:m-1);
response=processedNIR(:,m);
responsenew=[];

%% transform the label in response matrix
for i=1:n 
    num=response(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];
end
 
%% select the number of components
[~,~,~,~,~,PLSmsep]=plsregress(feature,responsenew,10);
figure(1) 
plot(1:10,PLSmsep(2,:),'b-o');
xlabel('Number of components');
ylabel('Estimated Mean Squared Prediction Error');
set(gca,'FontSize',22,'Fontname', 'Times New Roman');
% wait for selection of main component: 
ncomp = input('Select number of Components: ');
%feature=normalize(feature);
[Xloadings,Yloadings,Xscores,Yscores,betaPLS10,PLSPctVar,~,v_pls] = plsregress(feature,responsenew,ncomp);
featurereduced=Xscores;
v_pls=v_pls;
feature4pls= [featurereduced,response];
save('pls4training.mat','feature4pls');
save('plsvector.mat','v_pls');

fprintf('-------feature extraction completed--------\n');
end
