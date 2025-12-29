function [x,y] = HienAnTrungDiem(fxy,xdau,xcuoi,y0,N)
fxy = str2func(['@(x,y)',fxy]);
h = (xcuoi - xdau)/N;
x = xdau:h:xcuoi;
y = x;
y(1) = y0;
for i = 1:N
    y(i+1) = y(i) + (h/2) * fxy(x(i),y(i));
    y(i+1) = y(i) + h * fxy(x(i) + (h/2),y(i+1));
end
end