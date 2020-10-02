function [imgFeatures] = extractImgfeature(pathlocation,objectsize)
% the banch extraction of the image feature with the imagedataanalysiser
imgFeatures= zeros(objectsize,24);
parfor picnum =1:objectsize    
data =load(pathlocation+"\"+num2str(picnum)+".mat");
% initialize the object 
a = ImageDataAnalyzer2_loujiang;
 % picture analysis
a.extractFeatures(data.data.camW,data.data.camWUV,data.data.scale);
% combine together
 imgFeatures(picnum,:)=[a.features];
end
end

