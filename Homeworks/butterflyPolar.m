function [] = butterflyPolar()
    tethaData = 0:pi/32:8*pi;
    
    rData = (exp(1)).^sin(tethaData)-2*cos(4*tethaData)-(sin((2*tethaData-pi)/24).^5);

    polarplot(tethaData,rData,'r-');
    
end