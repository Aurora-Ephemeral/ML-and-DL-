function [NIRspectrum]=takeNIRspectrum(datasetpath,classsize)
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
%% class 1 
    start=0;% start number for each class
    NIRspectrum=[];%storage the extracted NIR spectrum
    i =1;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class
    
%% class 2
    i =2;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class    

%% class 3
    i =3;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class  

%% class 4
    i =4;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class
    
%% class 5
    i =5;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class  
    
%% class 6
    i =6;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class 
    
%% class 7
    i =7;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class 
    
%% class 8
    i =8;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class 
    
%% class 9
    i =9;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class  
    
 %% class 10
    i =10;
    parfor j =1:classsize
    picpath=strcat(datasetpath,'\',num2str(j+start),'.mat');
    data=load(picpath);
    spec=data.data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    NIRspectrum=[NIRspectrum;new];% add the new spectrums behind the previous extracted dataset
    start=start+classsize;% jump into startnumber of the next class  
fprintf('[status]:NIR extraction completed \n');
end