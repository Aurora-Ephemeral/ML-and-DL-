function [mfeature] = Mechsensor(tsensor1,tsensor2)


% take the second order derivitive 
tsensor2derivitive = secondorderDerivitiveMechanical(tsensor2);
% cut down the curve tail according to second order dirivitive 
tsensor2needed = cutdowntail(tsensor2,tsensor2derivitive);

% find the peaks
peaks2 = findpeaks(tsensor2needed,'MinPeakHeight',70, 'MinPeakWidth', 3);
peaks1 = findpeaks(tsensor1,'MinPeakProminence',100, 'MinPeakDistance',12);

% find the number of peaks
[~,number2] = size(peaks2);
[~,number1] = size(peaks1);

% initialize the output
max2=0;
max3=0;
max1=0;

% prevent the output from extand the maximun and allocate the output 
if number2 > 0      
max1 = peaks2(1);
end
if max1 >= 7500
    max2 = 8000;
    max3 =8000;
elseif number1 >= 1
   max2 = peaks1(1);
   if max2 >= 7500
       max3 = 8000;
   elseif number1 >=2
   max3 = peaks1(2);
   end
end

% add together the peak numbers
sumofnumber = number1+number2;

% output the feature
mfeature =[max1,max2,max3,sumofnumber];
end

