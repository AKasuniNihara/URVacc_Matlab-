function Num=CheckBlackColumn(BW,start1,end1,start2,end2)
    for colC=start1:end1
        sum = 0;
        for rowC=start2:end2
            pixelValueC = BW(rowC, colC);
            sum = sum + pixelValueC;
            if(pixelValueC ~= 0)
                continue;
            end
        end
        
    if(sum == 0)
        Num = colC;
        break
    end
    
    end

