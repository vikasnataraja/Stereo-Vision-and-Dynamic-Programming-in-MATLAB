function returnImage = disparitySSD(left, right, windowSize)
%disparitySSD Returns a 2D matrix that decribes the disparities between the 
% two input images using Sum of Squared Differences algorithmic method

disparityMaxLimit = 64;
[rows, cols, ~]=size(left);

% 3D array to store the difference values i.e correlation
mat3D = zeros(rows,cols,1+disparityMaxLimit);

% tmp array used to store corr. values
disparityImage  = zeros(rows,cols);

% create a window 
window = ones(windowSize, windowSize);    
for i=0:disparityMaxLimit
   % set initially to infinity 
   disparityImage(:) = Inf;
   index = rows*i+1:rows*cols; %left columns are subtracted, right columns are added
   
   % find SSD
   disparityImage(index) = (left(index) - right(index - rows*i)).^2;
   
   % for next iteration, the 3D array is updated
   mat3D(:,:,i+1) = conv2(disparityImage,window,'same');
    
end

% find the minimum value of the matrix
[minValue,minIndex]=min(mat3D,[],3);

% return the disparity matrix which is to be displayed as an image
disparityMap = minIndex-1;

% normalize the map
denom = max(disparityMap(:))-min(disparityMap(:));

returnImage=(disparityMap-min(disparityMap(:)))./denom;

end