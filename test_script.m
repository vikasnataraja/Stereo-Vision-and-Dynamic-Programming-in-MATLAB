% CSCI 5722 - Computer Vision
% HW - 4 Stereo Vision and Disparities
% Instructor: Ioana Fleming
% 
% Submitted by: Vikas Hanasoge Nataraja
% (viha4393@colorado.edu)

% read left and right stereo images
left = imread('frameLeftGray.png');
right = imread('frameRightGray.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK - 1 SSD 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate disparities using SSD 
SSDwinsize1 = disparitySSD(left, right, 1);

SSDwinsize5 = disparitySSD(left, right, 5);

SSDwinsize11 = disparitySSD(left, right, 11);

% use the MATLAB function
builtinDisparity = disparity(left, right);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK - 2 NCC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate disparities using NCC
NCCwinsize3 = disparityNCC(left, right, 3);

NCCwinsize5 = disparityNCC(left, right, 5);

NCCwinsize7 = disparityNCC(left, right, 7);

figure
subplot(3,1,1)
imshowpair(SSDwinsize1,builtinDisparity,'montage');
title('SSD with window size 1');

subplot(3,1,2)
imshowpair(SSDwinsize5,builtinDisparity,'montage');
title('SSD with window size 5');

subplot(3,1,3)
imshowpair(SSDwinsize11,builtinDisparity,'montage');
title('SSD with window size 11');

figure
subplot(3,1,1)
imshowpair(NCCwinsize3,builtinDisparity,'montage');
title('NCC with window size 3');

subplot(3,1,2)
imshowpair(NCCwinsize5,builtinDisparity,'montage');
title('NCC with window size 5');

subplot(3,1,3)
imshowpair(NCCwinsize7,builtinDisparity,'montage');
title('NCC with window size 7');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 3 - Uniqueness Constraint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uniqueDisparity = uniqueness(left,right,0.90,5);
figure
subplot(2,1,1)
imagesc(uniqueDisparity);colormap('jet')
title('Disparity map with uniqueness threshold');
subplot(2,1,2)
imshowpair(uniqueDisparity, builtinDisparity,'montage');
title('Compared with MATLAB function');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 4 - Smoothness Constraint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
smoothDisparity = smoothness(left, right,5, 0.9, 0.5);
figure;
subplot(2,1,1)
imagesc(smoothDisparity);colormap('jet')
title('Disparity map with smoothness threshold');
subplot(2,1,2)
imshowpair(smoothDisparity, builtinDisparity,'montage');
title('Compared with MATLAB function');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 5 - Outlier Map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SSDoutliers = outlierMap(SSDwinsize5,disparitySSD(right,left,5),1);

NCCoutliers = outlierMap(NCCwinsize5,disparityNCC(right,left,5),1);

figure
imshowpair(SSDoutliers,NCCoutliers,'montage');
title('Outlier map comparison between SSD(left) and NCC(right)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 6 - Depth Map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the stereoParameters object.
load('handshakeStereoParams.mat');
depthMatrixSSD = reconstructDepth(SSDwinsize5,stereoParams);
depthMatrixNCC = reconstructDepth(NCCwinsize5,stereoParams);

figure
subplot(2,1,1)
imagesc(depthMatrixSSD);colormap('jet');
title('Depth matrix with SSD disparity map');

subplot(2,1,2)
imagesc(depthMatrixNCC);colormap('jet');
title('Depth matrix with NCC disparity map');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 7 - Synthetic Stereo Sequences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% map of errors
figure
subplot(2,1,1)
imagesc(SSDwinsize5-builtinDisparity);colormap('jet')
title('Error map of SSD disparity with respect to ground truth')

subplot(2,1,2)
imagesc(NCCwinsize5-builtinDisparity);colormap('jet')
title('Error map of NCC disparity with respect to ground truth')

figure
subplot(2,1,1)
imshow(SSDwinsize5-builtinDisparity)
title('Error map of SSD disparity with respect to ground truth')

subplot(2,1,2)
imshow(NCCwinsize5-builtinDisparity)
title('Error map of NCC disparity with respect to ground truth')

% plot histogram

figure
subplot(2,1,1)
imhist(SSDwinsize5-builtinDisparity);
ylim([0 2000])
title('Histogram of differences between SSD and built in Disparity function')

subplot(2,1,2)
imhist(NCCwinsize5-builtinDisparity);
ylim([0 2000])
title('Histogram of differences between NCC and built in Disparity function')





