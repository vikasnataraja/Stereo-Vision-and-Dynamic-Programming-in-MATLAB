function d_color = display_dmap (d)
%DISPLAY_DMAP Summary of this function goes here
%   Detailed explanation goes here

max_d = max(max(d));
min_d = min(min(d));

% Normalize by scaling
normalizedDisparity = (d - min_d)/(max_d-min_d);

d_color = repmat(normalizedDisparity,1,1,3);

[rows, cols, ~] = size(d_color);

for i = 1:rows
        for j = 1:cols
            if isnan(d_color(i,j,:))
                d_color(i,j,1) = 1;
                d_color(i,j,2) = 1; 
                d_color(i,j,3) = 1;
            end     
        end
end

figure
imshow(d_color);


end


