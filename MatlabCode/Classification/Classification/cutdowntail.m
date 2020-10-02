function [tsensorneeded] = cutdowntail(tsensor,tsensorderivitive)
% cut down the big and useless tail behind the curve

[allvalue,~]=findpeaks(tsensorderivitive); % find the peak
minpeak = max(allvalue)/5; % set the minpeak value according to maxpeak

% find the position of the last minpeak and cut all the behind values
[~,position]= findpeaks(tsensorderivitive,'MinPeakHeight',minpeak);
% so that,when the curve become stable,we will finde it.
% cut the input
tsensorneeded =tsensor(1,1:max(position));
% control here if all the matrix is cutted, we donnot cut
if isempty(tsensorneeded)
tsensorneeded =tsensor;
end

end

