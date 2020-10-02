function [newpath,newpath2]=resizeimage3(picpath)
%% extract the image and compress into 224 and 227 
%input: 
    % location of the original dataset, in the template _Dataset2 with 4000
    % obejects 
%output: 
    % automatically save the resized data in 224x224 and 227x227 folder 
%% create two folders to storage the resized image in curruent folder
newpath='227x227';
newpath2='224x224';
mkdir(newpath);
mkdir(newpath2);
%% Class 1
start=0;
parfor j=1:400
   % preparation the storage folder
    i=1;
    num=num2str(i);
    newfolder=fullfile(newpath,num);%connect the storage path for specific class 
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;
%% Class 2
parfor j=1:400
   % preparation the storage folder
    i=2;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;
%% Class 3 
 parfor j=1:400
   % preparation the storage folder
    i=3;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;  
%% Class 4
parfor j=1:400
   % preparation the storage folder
    i=4;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;

%% Class 5
parfor j=1:400
   % preparation the storage folder
    i=5;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;
%% Class 6
parfor j=1:400
   % preparation the storage folder
    i=6;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;

%% Class 7
parfor j=1:400
   % preparation the storage folder
    i=7;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;

%% Class 8
parfor j=1:400
   % preparation the storage folder
    i=8;% class number 
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;

%% Class 9
parfor j=1:400
   % preparation the storage folder
    i=9;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
start=start+400;
%% Class 10
parfor j=1:400
   % preparation the storage folder
    i=10;
    num=num2str(i);
    newfolder=fullfile(newpath,num);
    newfolder2=fullfile(newpath2,num);
    mkdir(newfolder);
    mkdir(newfolder2);
    bango=j+start;
    location=fullfile(picpath,num2str(bango));
    % read image
    [imgRGB]=readImage(location);
    
    % cut the image 
    [result]=cutimage3(imgRGB);
    
    % resize the image and save 
    A=imresize(result,[227,227]);
    B=imresize(result,[224,224]);
    restore=strcat(newfolder,'\',num2str(j),'.jpg');
    restore2=strcat(newfolder2,'\',num2str(j),'.jpg');
    imwrite(A,restore);% size:224
    imwrite(B,restore2);% size:227
end
fprintf('[status]: Image resizing complete\n');
end