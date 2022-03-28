function [] = butterflyCurve()
    timeData = 0:1/16:100;
    
    
    x = inline('sin(t).*((exp(1)).^cos(t)-2.*cos(4.*t)-(sin(t./12)).^5)','t');
    
    y = inline('cos(t).*((exp(1)).^cos(t)-2.*cos(4.*t)-(sin(t./12)).^5)','t');

    xData = x(timeData);
    yData = y(timeData);
    
    subplot(2,1,1);plot(xData,timeData,yData,timeData,'.');title('x and y versus time');legend('x','y');xlabel('x');ylabel('time');
    
    subplot(2,1,2);plot(xData,yData);title('x versus y');xlabel('x');ylabel('y');axis('square');
end