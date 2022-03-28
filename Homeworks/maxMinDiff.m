function [result] = maxMinDiff(funcString,min,max)
    func=0;
    
    if max <= min
        result = 0;
        return;
    end

    try
      func = str2sym(funcString);
    catch exec
        disp('Invalid function!');
        result=0;
        return;
    end

    derivated = diff(func);

    roots = solve(derivated);

    for 1:1:length(roots)
        
    end
end