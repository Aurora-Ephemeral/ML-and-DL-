function [mechanicalFeatures] = extractMechanicalfeature(pathlocation,objectsize)
% the banch extraction of the mechanical feature with the function Mechsensor
mechanicalFeatures= zeros(objectsize,4); % initialize
parfor picnum =1:objectsize
    %load the data
    data =load(pathlocation+"\"+num2str(picnum)+".mat");
    % mechanical sensor feature get
    mechanicalFeatures(picnum,:) = Mechsensor(data.data.tSensor1,data.data.tSensor2);
end
end

