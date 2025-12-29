function [nghiem,solanlap] = lap(fx,fp,a,b,saiso)
fpi = str2func(['@(x)',fp]);
solanlap = 0;
x0 = (a + b)/2;
while(1)
    nghiem = fpi(x0);
    solanlap = solanlap + 1;
    e = abs(nghiem - x0);
    if e < saiso
        break;
    end
    x0 = nghiem;
end
end