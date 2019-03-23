% CSCI 5722 - Computer Vision
% HW - 4 Stereo Vision and Disparities
% Instructor: Ioana Fleming
% 
% Submitted by: Vikas Hanasoge Nataraja
% (viha4393@colorado.edu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 8 - Dynamic Programming
% Part A and B are accomplished by calling stereoDP
% Part C is accomplished by calling display_dmap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the stereoParameters object.
load('handshakeStereoParams.mat');

leftImage = rgb2gray(imread('frame_1L.png'));
rightImage = rgb2gray(imread('frame_1R.png'));

disparityMax = 63;
occ = 0.01;

dynamicImage = stereoDP(leftImage, rightImage, disparityMax, occ);

depthMatrix = reconstructDepth(dynamicImage,stereoParams);

display_dmap(dynamicImage)
title('Disparity image using dynamic programming');
display_dmap(depthMatrix)
title('Depth Estimation');
