function I = TichphanSimpson1_3(fx, a, b, N)
    f = str2func(['@(x)' fx]);
    if mod(N, 2) ~= 0
        error('Lỗi: Phương pháp Simpson 1/3 yêu cầu N phải là số CHẴN!');
    end
    h = (b - a) / N;
    tong_le = 0;
    for i = 1 : 2 : N - 1
        xi = a + i * h;
        tong_le = tong_le + f(xi);
    end
    tong_chan = 0;
    for i = 2 : 2 : N - 1
        xi = a + i * h;
        tong_chan = tong_chan + f(xi);
    end
    I = (h / 3) * (f(a) + f(b) + 4 * tong_le + 2 * tong_chan);
end