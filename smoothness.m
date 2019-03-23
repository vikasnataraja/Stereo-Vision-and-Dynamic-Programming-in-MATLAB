function smoothImage = smoothness(imageLeft, imageRight, sizeofWindow, uniqueThreshold, smoothnessThresh)
%SMOOTHNESS Uses a smoothness threshold to smooth out the pixels
% while calculating the disparities.

% imageLeft = double(rgb2gray(imageLeft));
% imageRight = double(rgb2gray(imageRight));

disparityLimit = 64;
[rows, cols, ~] = size(imageLeft);
disparityImage = zeros(rows,cols);
heightWindow = ceil(sizeofWindow/2);
widthWindow = ceil(sizeofWindow/2);

disparityScore = -5*ones(1,cols);


for i=1+heightWindow:rows-heightWindow
    
    for j=1+widthWindow:cols-widthWindow
        templateImage = imageLeft(i-heightWindow:i+heightWindow, j-widthWindow:j+widthWindow);
        smoothPixels = imgaussfilt(templateImage,smoothnessThresh);
        numerator = smoothPixels - mean2(smoothPixels);
        numsquared = numerator.^2;
        normalizedTemplate = numerator./sqrt(sum(numsquared(:)));
        %scanline of the right image
        for k=j:-1:max(1+widthWindow,j-disparityLimit)
            window = imageRight(i-heightWindow:i+heightWindow, k-widthWindow:k+widthWindow);
            numeratorWindow = window - mean2(window);
            squared = numeratorWindow.^2;
            normalizedWindow = numeratorWindow./sqrt(sum(squared(:)));
            disparityScore(k) = sum(sum(normalizedTemplate .* normalizedWindow));
        end
        [trueMatch, index] = max(disparityScore);
        % check for perfect match of the two images
        % Uniqueness constraint
        if uniqueThreshold >1 || uniqueThreshold <0
            error('Uniqueness Threshold needs to be between 0 and 1');
        else
            if trueMatch > uniqueThreshold
                disparityImage(i,j) = abs(j - index);
                
            end
        end

        % initialize score again for next iteration
        disparityScore = -5*ones(1,cols);
    end
end
smoothImage = disparityImage/255;
end


