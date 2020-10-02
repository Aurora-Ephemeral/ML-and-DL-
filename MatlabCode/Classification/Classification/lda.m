%% method of getting lda eigenvalue and eigenvaktor for all
% Principle: 
    % transform the original dimension in the dimension, where the distance
    % between the each two class are as far as possible
%
function[feature4lda,v_lda]= lda(processedNIR)
%% import the data
[n,m]= size(processedNIR);
feature = processedNIR(:,1:m-1);
result = processedNIR(:,m);

%% get distinct class
class = unique(result);
classnumber = length(class);
overallmean = mean(feature);
sw = zeros(1,1);
sb = zeros(1,1);
%% do the same process for each class
for i = 1:classnumber
featurethisid = find(result == class(i));
dataset = feature(featurethisid,:);
meanthis = mean(dataset);
dataset = dataset - repmat(meanthis, length(featurethisid),1);
%% between variance of features
sw = sw + dataset'*dataset;
%% within variance of features
sb = sb + length(featurethisid)*(meanthis-overallmean)'*(meanthis-overallmean);
end
%% get the target matrix to be optimized 
matrix = inv(sw)*sb;
%% calculate the eigenvalue and eigenvector
e =  eig(matrix);
[V,D] = eig(matrix);
%% Evaluation and select the component:
[a,b]= size(D);
Aufsum=sum(D,'all');
sumV=[];
ratio=[];
add=0;

for i=1:a
EV=abs(D(i,i));
add=add+EV;
sumV(i)=add;
ratio(i)=sumV(i)/Aufsum;
end
figure(1)
plot(1:a,ratio,'b-o','Linewidth',2)
xlabel('number of Eigenvalue');
ylabel('Percentage of main Component');
set(gca,'FontSize',28,'Fontname', 'Times New Roman');
% wait for selection of main component: 
numComp = input('Select number of Components for lda: ');
%% feature reduction in desired dimensions
v_lda=V(:,1:numComp);
feature=feature*v_lda;
feature4lda= [feature,result];
%% automatically save the key dataset 
save('lda4training.mat','feature4lda');% for training the svm
save('ldavector.mat','v_lda');%for dimension reduction by lda 
fprintf('-------feature extraction completed--------\n');
end