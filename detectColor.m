function vaccine = detectColor(I)
    RG = rgb2gray(I);
% identify red components
    R = I(:,:,1);
    Fr = imsubtract(R,RG);

    Fr = im2bw(Fr, 0.1);
    
    [Lr, obj_r] = bwlabel(Fr,8);
    
    

% identify green components
    G = I(:,:,2);
    Fg = imsubtract(G,RG);

    Fg = im2bw(Fg, 0.1);
   
    [Lg, obj_g] = bwlabel(Fg,8);
    
    if(obj_r > 0)
    %fprintf('Sinopharm\n');
    vaccine = 'Sinopharm';
    elseif(obj_g > 0)
        %fprintf('Pfizer\n');
         vaccine = 'Pfizer';
    else
        vaccine = '?';
    end