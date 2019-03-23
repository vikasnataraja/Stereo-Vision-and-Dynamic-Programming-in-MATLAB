function returnImage = disparityNCC(leftimage, rightimage, sizeofWindow)
%disparityNCC Returns a 2D matrix describing the disparities between
% the two input images using Normalized Cross-Correlation algorithmic method

% NCC = (1/N)*sum((1/sd1*sd2)*I1*I2) 
% leftimage = double(rgb2gray(imageLeft));
% rightimage = double(rgb2gray(imageRight));

disparityLimit = 64;
[rows, cols, ~] = size(leftimage);
disparityImage = zeros(rows,cols);
heightWindow = ceil(sizeofWindow/2);
widthWindow = ceil(sizeofWindow/2);

disparityScore = -5*ones(1,cols);


for i=1+heightWindow:rows-heightWindow
    
    for j=1+widthWindow:cols-widthWindow
        templateImage = leftimage(i-heightWindow:i+heightWindow, j-widthWindow:j+widthWindow);

        numerator = templateImage - mean2(templateImage);
        numsquared = numerator.^2;
        normalizedTemplate = numerator./sqrt(sum(numsquared(:)));
        %scanline of the right image
        for k=j:-1:max(1+widthWindow,j-disparityLimit)
            window = rightimage(i-heightWindow:i+heightWindow, k-widthWindow:k+widthWindow);
            numeratorWindow = window - mean2(window);
            squared = numeratorWindow.^2;
            normalizedWindow = numeratorWindow./sqrt(sum(squared(:)));
            disparityScore(k) = sum(sum(normalizedTemplate .* normalizedWindow));
        end
        [trueMatch, index] = max(disparityScore);
        % check for perfect match of the two images
        % Uniqueness constraint
        %if trueMatch > 0.95
        disparityImage(i,j) = abs(j - index);
        %end

        % initialize score again for next iteration
        disparityScore = -5*ones(1,cols);
    end
end

% normalize the map
denom = max(disparityImage(:))- min(disparityImage(:));

returnImage=(disparityImage-min(disparityImage(:)))./denom;
end