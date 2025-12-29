function result = tinh_dao_ham_theo_mang_du_lieu(mang_x, mang_y, x_value, phuongphap, saiso)
% Input:
%       mang_x, mang_y: Mảng dữ liệu
%       x_value: Giá trị x cần tìm (phải nằm trong mang_x)
%       phuongphap : Chuỗi kí tự ('Xấp xỉ tiến', 'Xấp xỉ lùi', 'Xấp xỉ trung tâm')
%       saiso  : Chuỗi kí tự ('O(h)', 'O(h^2)')

    % Kiểm tra x có nằm trong mảng không
    idx = find(abs(mang_x - x_value) < 1e-9, 1);
    
    if isempty(idx)
        error('Lỗi: Giá trị x phải nằm trong mảng dữ liệu x!');
    end
    
    % Tính bước nhảy h
    if length(mang_x) > 1
        h_calculated = mang_x(2) - mang_x(1);
    else
        error('Lỗi: Mảng phải có ít nhất 2 phần tử!');
    end
    
    % Tính 
    try
        switch phuongphap
            case 'Xấp xỉ tiến'
                if strcmp(saiso, 'O(h)')
                    result = (mang_y(idx + 1) - mang_y(idx)) / h_calculated;
                else % O(h^2)
                    result = (-mang_y(idx + 2) + 4*mang_y(idx + 1) - 3*mang_y(idx)) / (2 * h_calculated);
                end
                
            case 'Xấp xỉ lùi'
                if strcmp(saiso, 'O(h)')
                    result = (mang_y(idx) - mang_y(idx - 1)) / h_calculated;
                else % O(h^2)
                    result = (3*mang_y(idx) - 4*mang_y(idx - 1) + mang_y(idx - 2)) / (2 * h_calculated);
                end
                
            case 'Xấp xỉ trung tâm'
                if strcmp(saiso, 'O(h)')
                    error('Lỗi: PP Trung tâm phải là O(h^2)!');
                else % O(h^2)
                    result = (mang_y(idx + 1) - mang_y(idx - 1)) / (2 * h_calculated);
                end
        end
    catch
        % Bắt lỗi khi vượt quá kích thước mảng
        error('Lỗi: Không đủ điểm dữ liệu để tính tại vị trí này (bị tràn biên)!');
    end
end