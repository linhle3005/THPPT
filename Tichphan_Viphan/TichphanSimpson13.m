function result = TichphanSimpson13(xi,yi)
n = length(xi) - 1;
if mod(n,2) ~= 0
    error('Simpson 1/3 yêu cầu số đoạn phải chẵn');
end
h = xi(2) - xi(1);
result = yi(1) + yi(end);
for i = 2:n
    if mod(i,2) == 0
        result = result + 4*yi(i);
    else
        result = result + 2*yi(i);
    end
end
    result = result * h/3;
end