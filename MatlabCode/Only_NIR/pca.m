function [pca4training,v_pca]=pca(processedNIR)
[n,m]=size(processedNIR);
X=processedNIR(:,1:m-1);
label=processedNIR(:,m);

%convariance 
X_std=mapstd(X);
X_cov=cov(X_std);
[V,D]=eig(X_cov);
%Evaluation:
[a,b]= size(D);
Aufsum=sum(D,'all');
sumV=[];
ratio=[];
add=0;

for i=0:a-1
EV=abs(D(a-i,b-i));
add=add+EV;
sumV(i+1)=add;
ratio(i+1)=sumV(i+1)/Aufsum;
end
figure(1)
plot(1:a,ratio,'b-o')
xlabel('number of Eigenvalue');
ylabel('Percentage of main Component');
set(gca,'FontSize',22,'Fontname', 'Times New Roman');
% wait for selection of main component: 
numComp = input('Select number of Components: ');

v_pca=V(:,b+1-numComp:b);
X_select=X*v_pca;
pca4training=[X_select,label];
save('pca4training.mat','pca4training');
save('pcavector.mat','v_pca');
fprintf('[status]:feature extraction completed\n');
end

