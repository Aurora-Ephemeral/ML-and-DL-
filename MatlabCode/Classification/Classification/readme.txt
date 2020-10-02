MainScript:
	01 The main function is saved in "MainScript.mat" file 

	02 Image method  in the code is determined but there are 4 options for processing NIR spectrum

	03 please Separate training set and test set before running the main funciton 

	04 For all the function relevant to the NIR spectrum, please select the function corresponded to the method for each process
   	 e.g. if you want to use pls method to extract for feature dimension reduction, please select: plspreprocess->pls->Predictplspreprocess->Predictpls 

	05 Since the running takes a while, you can also save the data genereated from the extract function: e.g. trainImgfeature. In the second time you can 
   	load these extracted features directly and comment the function in trainset extract. It will save much time. 

Folder: 

	01 confusionmatrix contains the confusion matrix combine the feature from image, mechanical sensor and NIR based on pls method 
	
	02 feature matrix contains the extracted features matrix by ourselves, you can use them directly to train a model
	
	03 If the result is not satisfactory, pleas contact us
