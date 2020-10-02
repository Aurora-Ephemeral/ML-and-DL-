function [imdsTrain,imdsValidation,imdsTest]=imgsplit(rootpath,imgsize)
%% preparation for Transferlerning
% split the total 4000 object into Training part, Validation part and Test
% part 
% test data is the first 50 objects in each class
% the rest data are used for training and validation and it should be
% rename from 1 to 350 
% before run this code, the size of the image should be corrected according
% to requirement of pre trained network  
% rename the class number from 01 to 10 

%input: 
    %rootpath: the loacation where the compressed images are saved 
    %size: insert the desired size to save the splited data in
    %corresponding folder(options:224/227)
    
%output:
    % it will save the splited image in the correspongding folder
    % automatically for example in this template, the test image will save
    % in 'testpic224' abn training image will save in 'trainpic224' similar to 227x227  
%% define the path default: current working space 
testpath=strcat('testpic',num2str(imgsize));
trainpath=strcat('trainpic',num2str(imgsize));

%% class 1
% prepare for the storage folder 
    i=1;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
%% class 2
% prepare for the storage folder 
    i=2;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
 
 %% class 3
% prepare for the storage folder 
    i=3;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
 %% class 4
% prepare for the storage folder 
    i=4;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
 
 %% class 5
% prepare for the storage folder 
    i=5;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
 %% class 6
% prepare for the storage folder 
    i=6;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
 %% class 7
% prepare for the storage folder 
    i=7;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
 %% class 8
% prepare for the storage folder 
    i=8;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end

    
 %% class 9
% prepare for the storage folder 
    i=9;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
    
    %% class 10
% prepare for the storage folder 
    i=10;
    classpath=strcat(rootpath,'\',num2str(i));%load the compressed data 
    % prepare the 
    savetestpath=strcat(testpath,'\',num2str(i,'%02d'));
    savetrainpath=strcat(trainpath,'\',num2str(i,'%02d'));
    mkdir(savetestpath);
    mkdir(savetrainpath);
    %split the data 
    parfor j=1:400
        % extract the testdata and save in desired path 
        if j>0 & j< 51
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 50 
        picsavepath=strcat(savetestpath,'\',num2str(j,'%03d'),'.jpg');
        imwrite(pic,picsavepath);
        else
        % extract the traindata and save in desired path      
        picpath=strcat(classpath,'\',num2str(j),'.jpg');
        pic=imread(picpath);
        %rename the picture from 1 to 350 
        picsavepath=strcat(savetrainpath,'\',num2str(j-50,'%03d'),'.jpg');
        imwrite(pic,picsavepath);     
        end
    end
%transform the format for transferlearning 
imdsTest = imageDatastore(testpath,'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
imds=imageDatastore(trainpath,'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%spilt train and validation with ration 0.75 
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.75,'randomized');
%save the 3 kinds of data automatically, the store path is shown bellow:
imgtrainpath=strcat(num2str(imgsize),'Train.mat');
imgvalidationpath=strcat(num2str(imgsize),'Validation.mat');
imgtestpath=strcat(num2str(imgsize),'Test.mat');
save(imgtrainpath,'imdsTrain'); 
save(imgvalidationpath,'imdsValidation'); 
save(imgtestpath,'imdsTest'); 
fprintf('[status]: image spilt complete\n');
end