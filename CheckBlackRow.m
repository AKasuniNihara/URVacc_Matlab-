function Num =CheckBlackRow(BW,start1,end1,start2,end2)
    for rowR=start1:end1
        sum = 0;
        for colR=start2:end2
            pixelValueR = BW(rowR, colR);
            sum = sum + pixelValueR;
            if(pixelValueR ~= 0)
                continue;
            end
        end
        
    if(sum == 0)
        Num = rowR;
        break
    end
    
    end

