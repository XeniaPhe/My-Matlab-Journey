function [sine] = sine(radians,debugMode,n,errorGraph,errorGraphRange)
% sine  Sine of an angle in radians
%
% Synopsis: x = sine(radians)
%           x = sine(radians,debugMode)
%           x = sine(radians,debugMode,n)
%           x = sine(radians,debugMode,n,errorGraph)
%           x = sine(radians,debugMode,n,errorGraph,errorGraphRange)
%
% Input:    radians          =  The angle in radians at which sine is calculated
%
%           debugMode        =  (Optional) Enables the debug mode when a non-zero
%           number is passed.Debug mode prints the relative error after each term is
%           calculated and it might get annoying.
%                               Default: debugMode = 0
%
%           n                =  (Optional) The number of terms the function will
%           evaluate to calculate the sine
%                               Default: n = 150
%
%           errorGraph       =  (Optional) Enables the graphing mode when a
%           non-zero number is passed.Graph mode prints the graph of
%           'Relative error-Number of terms' graph after the sine is calculated
%                               Default: errorGraph = 0
%
%           errorGraphRange  =  (Optional) The number of terms that will be
%           included in the error graph
%                               Default: errorGraphRange = n
%
% Output:   x = radians

% Notes:    Use sine(0.9,1,8,1,8) for the test case

    if ~exist("debugMode","var")
        debugMode=0;
    end

    if ~exist("n","var")
        n = 150;
    elseif n <= 0
        n = 150;
    end

    if ~exist("errorGraph","var")
        errorGraph=0;
    end

    if ~exist("errorGraphRange","var")
        errorGraphRange=n;
    elseif errorGraphRange > n
        errorGraphRange=n;
    elseif errorGraphRange <= 0
        errorGraphRange=1;
    end

    radians = mod(radians,2*pi);
    %This modulo prevents us from calculating insanely huge numbers -hence
    %Nan- due to exponentiation but it creates some error due
    %to floating point precision

    sine=0;
    trueSine = sin(radians);
    error = zeros(1,n);

    getTerm = inline('(x.^n)/factorial(n)','x','n');    %x=radians

    fprintf('\n');
    for k=1:1:n
        power = 2*k-1;
        if mod(k,2)==1
            sine = sine + getTerm(radians,power);
        else
            sine = sine - getTerm(radians,power);
        end
        
        error(k) = ((trueSine-sine)/trueSine)*100;

        if debugMode~=0
            if k==1
                fprintf('(First Term) Current relative error = %.18f%%\n',error(k));
            elseif k==2
                fprintf('(Second Term) Current relative error = %.18f%%\n',error(k));
            elseif k==3
                fprintf('(Third Term) Current relative error = %.18f%%\n',error(k));
            else 
                fprintf('(%dth Term) Current relative error = %.18f%%\n',k,error(k));
            end
        end
        
        if k~=1 & error(k) == error(k-1)
            error(k:1:n) = error(k);
            break;
        end
    end

    if errorGraph~=0
        plot(1:1:errorGraphRange,error(1:1:errorGraphRange));title('Number of terms x Relative Error');
        xlabel('Number Of Terms');ylabel('Relative Error %');
    end
end