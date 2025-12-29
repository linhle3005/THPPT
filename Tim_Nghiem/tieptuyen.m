function [nghiem,solanlap] = tieptuyen(fx,a,b,saiso)
solanlap = 0;
x0 = (a + b)/2;
syms x;
f = fx(x);
fd = diff(f,x);
fi = matlabFunction(f);
fdi = matlabFunction(fd);
while(1)
    nghiem = x0 - (fi(x0)/fdi(x0));
    solanlap = solanlap + 1;
    e = abs(nghiem - x0);
    if e < saiso
        break;
    end
    x0 = nghiem;
end