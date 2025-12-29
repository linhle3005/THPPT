function [x,y] = HienAnHinhThang(fxy,xdau,xcuoi,y0,N,saiso)
fxy = str2func(['@(x,y)',fxy]);
h = (xcuoi - xdau)/N;
x = xdau:h:xcuoi;
y = x;
y(1) = y0;
for i = 1:N
    y(i+1) = y(i) + h * fxy(x(i),y(i));
    while(1)
        c = y(i+1);
        y(i+1) = y(i) + (h/2) * (fxy(x(i),y(i)) +  fxy(x(i+1),y(i+1)));
        if abs(y(i+1) - c) < saiso
            break;
        end
    end
end
end