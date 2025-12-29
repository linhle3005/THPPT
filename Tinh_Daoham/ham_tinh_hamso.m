function result = ham_tinh_hamso(f, x_value, h, phuongphap, saiso)
%   Input
%       f      : Hàm số dưới dạng function handle (ví dụ: @(x) x^2)
%       x_value  : Giá trị x cần tính đạo hàm (số thực)
%       h      : Bước nhảy (số thực)
%       phuongphap : Chuỗi kí tự ('Xấp xỉ tiến', 'Xấp xỉ lùi', 'Xấp xỉ trung tâm')
%       saiso  : Chuỗi kí tự ('O(h)', 'O(h^2)')
%   Output:
%       result : Kết quả đạo hàm tính được

    % Kiểm tra nếu f không phải là hàm số thì báo lỗi
    if ~isa(f, 'function_handle')
        error('Input f phải là một function handle (ví dụ: @(x) x^3)');
    end

    switch phuongphap
        case 'Xấp xỉ tiến'
            if strcmp(saiso, 'O(h)')
                % Công thức tiến O(h): (f(x+h) - f(x)) / h
                result = (f(x_value + h) - f(x_value)) / h;
            else % O(h^2)
                % Công thức tiến O(h^2): (-3f(x) + 4f(x+h) - f(x+2h)) / 2h
                result = (-3*f(x_value) + 4*f(x_value + h) - f(x_value + 2*h)) / (2*h);
            end

        case 'Xấp xỉ lùi'
            if strcmp(saiso, 'O(h)')
                % Công thức lùi O(h): (f(x) - f(x-h)) / h
                result = (f(x_value) - f(x_value - h)) / h;
            else % O(h^2)
                % Công thức lùi O(h^2): (3f(x) - 4f(x-h) + f(x-2h)) / 2h
                result = (3*f(x_value) - 4*f(x_value - h) + f(x_value - 2*h)) / (2*h);
            end

        case 'Xấp xỉ trung tâm'
            if strcmp(saiso, 'O(h)')
                % Báo lỗi thay vì gán vào UI như trong App
                error('Lỗi: Phương pháp Trung tâm không hỗ trợ O(h), vui lòng chọn O(h^2)!');
            else % O(h^2)
                % Công thức trung tâm O(h^2): (f(x+h) - f(x-h)) / 2h
                result = (f(x_value + h) - f(x_value - h)) / (2*h);
            end
            
        otherwise
            error('Phương pháp không hợp lệ. Chọn: "Xấp xỉ tiến", "Xấp xỉ lùi", hoặc "Xấp xỉ trung tâm"');
    end
end