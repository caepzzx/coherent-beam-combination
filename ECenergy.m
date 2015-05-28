function EC=ECenergy(radius,I2,L2)
    radius=radius/L2*size(I2,1);%unit transform between meter and pixel
    [X2,Y2]=meshgrid(1:size(I2,1),1:size(I2,2));
    mask=(X2-round(size(I2,1)/2)).^2+(Y2-round(size(I2,2)/2)).^2<radius^2;
    mask=double(mask);
    EC=sum(sum(mask.*I2))/sum(sum(I2));
end