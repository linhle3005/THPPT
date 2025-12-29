function result = TPHinhthang(xi,yi)
n = length(xi);
if length(yi) ~= n
    error('x và y phải cùng số phần tử!');
end
h = (xi(end) - xi(1)) / (n-1);
if max(abs(diff(xi)-h)) > 1e-9
    error('Các điểm x phải cách đều!');
end
result = (yi(1) + yi(end))/2;
for i = 2:n-1
    result = result + yi(i);
end
result = result * h;
end