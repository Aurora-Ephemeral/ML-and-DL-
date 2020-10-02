function [tsensorafter] = secondorderDerivitiveMechanical(tsensor)
% take the second order derivitive with sgo method bei definded length and
% window
[~,g] = sgolay(2,3); % seleted sgo filter length and window.(bigger smoother, but lost the small tips.)
% take the second order dirivitive of the data
  deriv =2;
  for i = 1:size(tsensor,1)    
               tsensor(i,:) = conv(tsensor(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end
  tsensorafter = tsensor;
end

