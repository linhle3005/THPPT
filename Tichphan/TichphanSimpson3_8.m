function I = TichphanSimpson3_8(fx, a, b, N)
    f = str2func(['@(x)' fx]);
    if mod(N, 3) ~= 0
        error('Lỗi: Phương pháp Simpson 3/8 yêu cầu N phải chia hết cho 3');
    end
    h = (b - a) / N;
    tong = 0;
    for i = 1:(N-1) 
        idx = i + 1;
        if mod(i, 3) == 0
            tong = tong + 2 * f(idx);
        else
            tong = tong + 3 * f(idx); 
        end
    end
    I = (3*h / 8) * (f(a) + f(b) + 4 * tong_le + 2 * tong_chan);
end
