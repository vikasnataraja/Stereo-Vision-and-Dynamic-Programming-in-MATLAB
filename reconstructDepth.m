function returnParam = reconstructDepth(disparityMap, stereoParameters)
%reconstructDepth Returns a depth matrix from a disparity map.
% stereoParams is taken by loading the video matrix and it gives
% camera attributes.

% From Szelinski's book eqn 11.1,
% depth Z = f*B/d
% where f=focal length, B=baseline, d = disparities

    corner1 = stereoParameters.CameraParameters1.PrincipalPoint;
    corner2 = stereoParameters.CameraParameters2.PrincipalPoint;
    
    % calculate baseline B using sqrt((x2-x1)^2 + (y2-y1).^2)
    baseline = sqrt((corner2(1)-corner1(1)).^2 + (corner2(2)-corner1(2)).^2);
    
    % next, find focal length f of left camera 
    focalLen = stereoParameters.CameraParameters1.FocalLength;
    
    % focalLen is in pixels. so I convert it to mm using:
    % 1px = 0.26mm 
    % also take average
    focal = ((focalLen(1)*0.26) + (focalLen(2)*0.26))/2;    
    
    [rows, cols] = size(disparityMap);
    returnParam = zeros(rows,cols);
    
    for i = 1:rows
        for j=1:cols
            % obtain disparity. 
            disparityValue = disparityMap(i,j);
            % if disparity Value is 0 at any pixel, set
            % depth to max value since they are inversely proportional
            % (used the hints from Piazza discussions)
            if disparityValue == 0
                depth = 255;
            else
            % calculate depth.
                depth = (focal*baseline)/disparityValue;
            end
            % place in return matrix.
            returnParam(i, j) = depth;
        end
    end
end
