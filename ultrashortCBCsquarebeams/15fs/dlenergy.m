function dle=dlenergy(I2,rdlx,rdly,X2,Y2)
%calculate energy in diffraction limit 
    mask=(abs(X2)<rdlx).*(abs(Y2)<rdly);
%     figure,imshow(mask,[])
    
    dle=sum(sum(mask.*I2));
end