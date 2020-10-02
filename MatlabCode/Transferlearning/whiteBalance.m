 function [imgWB]=whiteBalance(imgRGB)
 %% white balance 
 %two options: 1 time and 4 times 
 %% code:
Rx4 = imgRGB(:,:,1)*4;  Gx4 = imgRGB(:,:,2)*4;  Bx4 = imgRGB(:,:,3)*4; 
R = imgRGB(:,:,1);      G = imgRGB(:,:,2);      B = imgRGB(:,:,3);
Rave = mean(mean(R)); 
Gave = mean(mean(G)); 
Bave = mean(mean(B));
Kave = (Rave + Gave + Bave) / 3;
R2 = (Kave/Rave)*Rx4; G2 = (Kave/Gave)*Gx4; B2 = (Kave/Bave)*Bx4; 
imgWB = cat(3, R2, G2, B2);
            
end