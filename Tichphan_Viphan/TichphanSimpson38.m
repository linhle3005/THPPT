function I = TichphanSimpson38(fx,a,b,N)
if mod(N,3) ~= 0
    error('N phải chia hết cho 3');
end
fxi = str2func(['@(x)',vectorize(fx)]);
h = (b - a)/N;
x = a:h:b;
y = fxi(x);
I = y(1) + y(end);
for i = 2:N
    if mod(i-1,3) == 0
        I = I + 2*y(i);
    else
        I = I + 3*y(i);
    end
end
I = I * 3*h/8;
end