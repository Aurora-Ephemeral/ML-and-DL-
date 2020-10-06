function [labels] = extractLabel(pathlocation,objectsize)
% the banch extraction of the mechanical feature with the function Mechsensor
labels= zeros(objectsize,1); % initialize
parfor picnum =1:objectsize
    %load the data
    data =load(pathlocation+"\"+num2str(picnum)+".mat");
    % mechanical sensor feature get
    labels(picnum,:) = data.data.classID;
end
end
