function [result]=cutimage(image,posx,posy,length,breadth)
sidelength = [];

if length>breadth
   sidelength=length;
else
   sidelength=breadth;
end
compare=[sidelength,2031-posy,2526-posx];
sidelength=min(compare);
result = image(posy:posy+sidelength,posx:posx+sidelength,:);
end