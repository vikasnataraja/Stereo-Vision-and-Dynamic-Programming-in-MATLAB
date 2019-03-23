function returnBackTrack = backtracking(direction)
%BACKTRACKING Summary of this function goes here
%   Detailed explanation goes here

returnBackTrack = NaN(rows,cols);

secondIndex=cols;
firstIndex=cols;
        while(costmatrixD(firstIndex,secondIndex,2)~=4)
            if(costmatrixD(firstIndex,secondIndex,2)== 1)
                returnBackTrack(row,firstIndex)=-secondIndex+firstIndex;
                firstIndex=firstIndex-1;
                secondIndex=secondIndex-1;
            elseif(costmatrixD(firstIndex,secondIndex,2)==2)
                secondIndex=secondIndex-1;
            elseif(costmatrixD(firstIndex,secondIndex,2)==3)
                firstIndex=firstIndex-1;
            end
            if firstIndex<=0 || secondIndex<=0
               error('Indices do not match or are out of bounds'); 
            end

        end
        
end
    
    


end