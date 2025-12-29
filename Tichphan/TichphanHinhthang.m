function I = TichphanHinhthang(fx, a, b, N)
    f = str2func(['@(x)' fx]);
    h = (b - a) / N;
    tong = 0;
    for i = 1 : N - 1
        xi = a + i * h;
        tong = tong + f(xi);
    end
    I = (h / 2) * (f(a) + f(b) + 2 * tong);
end