function I = TichphanSimpson(fx,a,b,N)
if mod(N,2) ~= 0
    print('N phai la so chan!');
end
fxi = str2func(['@(x)',fx]);
h = (b - a)/N;
sum_even = 0; %tổng chẵn
sum_odd = 0; %tổng lẻ
for i = 2:2:N - 1
    xi = a + i*h;
    sum_even = sum_even + fxi(xi);
end
for i = 1:2:N - 1
    xi = a + i*h;
    sum_odd = sum_odd + fxi(xi);
end
I = (h/3) * (fxi(a) + fxi(b) + 4*sum_odd + 2*sum_even);
end