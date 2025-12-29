function [nghiem,solanlap] = chiadoi(fx,a,b,saiso)
solanlap = 0;
while(1)
    nghiem = (a + b)/2;
    if fx(nghiem)*fx(a) < 0
        b = nghiem;
    else
        a = nghiem;
    end
    solanlap = solanlap + 1;
    e = abs(b - a);
    if e < saiso
        break;
    end
end
end