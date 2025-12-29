function [x,y] = RK(fxy,xdau,xcuoi,y0,N)
fxy = str2func(['@(x,y)',fxy]);
h = (xcuoi - xdau)/N;
x = xdau:h:xcuoi;
y = x;
y(1) = y0;
for i = 1:N
    k1 = h * fxy(x(i),y(i));
    k2 = h * fxy(x(i) + (h/2),y(i) + (k1/2));
    k3 = h * fxy(x(i) + (h/2),y(i) + (k2/2));
    k4 = h * fxy(x(i) + h,y(i) + k3);
    y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4)/6;
end
end