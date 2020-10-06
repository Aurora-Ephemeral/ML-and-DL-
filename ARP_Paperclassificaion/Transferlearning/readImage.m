function [imgRGB]=readImage(location)
 load(location);
 img = data.camW;
 roiAC = [60 2585 70 2100];
 imgRGB = img;
 imgRGB = imgRGB(roiAC(3):roiAC(4),roiAC(1):roiAC(2),:);
end