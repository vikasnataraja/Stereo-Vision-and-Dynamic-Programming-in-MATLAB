function returnDisparity = stereoDP(e1,e2,maxDisp,occ)
%stereoDP Returns a disparity map using dynamic programming.
% Also performs backtracking.
% e1 and e2 are left and right scanlines,
% maxDisp is the maximum Disparity limit,
% occ is the occlusion penalty factor

[rows, cols, ~]=size(e1);
windowSize = 5;

% I am using windows because it reduces run time
% Now, pad extra rows and columns to fit windows at the beginning and the end
e1(rows+windowSize*2,cols+windowSize*2) = 0; 
e2(rows+windowSize*2,cols+windowSize*2) = 0; 
    
costmatrixD = zeros(cols,cols,2);    
returnDisparity = NaN(rows,cols);

for row=1:rows
%     fprintf('Rownumber %d\n',row);

    costmatrixD(1:cols,1:cols,1)=inf;
        
    for j=1:cols
        for i=j:min(cols,j+maxDisp)
           if(j==1)
                leastScore=(i-1)*occ;
                direction=4;
           else
                [leastScore,direction]=min([costmatrixD(i-1,j-1,1),costmatrixD(i,j-1,1)+occ,costmatrixD(i-1,j,1)+occ]);                   
           end
           
           % I am windowing the image because it speeds the code
           % rather than going through every pixel individually
           windowE1=e1(row:row+windowSize*2,i:i+windowSize*2);
           windowE2=e2(row:row+windowSize*2,j:j+windowSize*2);
           d = sum(sum((double(windowE1)-double(windowE2)).^2));
           % d = sum(sum((double(e1)-double(e2)).^2));
           
           if (i==cols)
               % using formula for cost, assign value
               costmatrixD(i,j,1)= d +(cols-j)*occ+leastScore;          
           elseif (j==cols)
               costmatrixD(i,j,1)= d +(cols-i)*occ+leastScore;             
           else
               costmatrixD(i,j,1)= d + leastScore ;    
           end
           costmatrixD(i,j,2)=direction;
        end
    end
               
% start backtracking part

% here I use the directions from part A and track the 
% path of minimum cost from (N,N) to (i,j)

firstIndex=cols;
secondIndex=cols;
while(costmatrixD(firstIndex,secondIndex,2)~=4)
    if(costmatrixD(firstIndex,secondIndex,2)== 1)
        returnDisparity(row,firstIndex)=-secondIndex+firstIndex;
        firstIndex=firstIndex-1;
        secondIndex=secondIndex-1;
     elseif(costmatrixD(firstIndex,secondIndex,2)==2)
        secondIndex=secondIndex-1;
     elseif(costmatrixD(firstIndex,secondIndex,2)==3)
        firstIndex=firstIndex-1;
     end
     if firstIndex<=0 || secondIndex<=0
        error('Indices are out of bounds'); 
     end
end
        
end

end