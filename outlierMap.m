function outlier = outlierMap(LR, RL, TLR)
%OUTLIERMAP Summary of this function goes here
%   Detailed explanation goes here

[rows,cols,~]=size(LR);
outlier=zeros(rows,cols);
for i=1:rows
    for j=1:cols
        rightDisparity=round(j-LR(i,j));
        % check if within bounds
        if(rightDisparity > cols || rightDisparity < 1)
            outlier(i,j)=1;
        else
            leftDisparity=rightDisparity+RL(i,rightDisparity);
            if (abs(leftDisparity-j) <= TLR)
                outlier(i,j)=0;
            else
                outlier(i,j)=1;
            end
        end
    end
end



end