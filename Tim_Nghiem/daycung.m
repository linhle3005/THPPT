function [nghiem,solanlap] = daycung(fx,a,b,saiso)
solanlap = 0;
x0 = a;
while(1)
    nghiem = (a*fx(b) - b*fx(a))/(fx(b) - fx(a));
    if (fx(a)*fx(nghiem)<0)
        b = nghiem;
    else
        a = nghiem;
    end
    solanlap = solanlap + 1;
    e = abs(nghiem-x0);
    if e < saiso
        break;
    end
    x0 = nghiem;
end