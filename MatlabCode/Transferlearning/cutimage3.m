function [result]=cutimage3(image)
%%find a 600*600 square in the image that contains the object

[height,width,~]=size(image);% find image size
squaresize=600;
movingstep=100; 

Sum_image_RGB=sum(image,3);

rowposition=1;

for i=1:movingstep: height-squaresize+1
    columnposition=1;
    for j=1:movingstep:width-squaresize+1
        Tempmatrix=Sum_image_RGB(i:i+squaresize-1, j:j+squaresize-1); %tempmatrix is a 600*600 square matrix in the image pixel range
        Sum_each_area(rowposition,columnposition)= sum(Tempmatrix(:));%add the r,g,b value of all pixels in each 600*600 square and store in matrix Sum_each_area
        columnposition=columnposition+1; %rowposition,columnposition record the postion of each 600 square inside the image
    end
    rowposition=rowposition+1;
end
[maxrowposition,maxcolumnposition]=find(Sum_each_area==max(Sum_each_area(:)));%find the 600 square with the biggest value (object)
result=image((maxrowposition-1)*movingstep+1:(maxrowposition-1)*movingstep+squaresize,(maxcolumnposition-1)*movingstep+1:(maxcolumnposition-1)*movingstep+squaresize,:);
% cut the image to the 600*600 square 
end