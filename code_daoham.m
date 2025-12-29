classdef Dao_ham < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        PP_daoham                   matlab.ui.control.DropDown
        ChnphngphpohmDropDownLabel  matlab.ui.control.Label
        Saiso                       matlab.ui.control.DropDown
        ChngitrsaisOhhocOh2DropDownLabel  matlab.ui.control.Label
        ketqua_result               matlab.ui.control.EditField
        Ketqua_button               matlab.ui.control.Button
        Giatri_x                    matlab.ui.control.EditField
        Buocnhay_h                  matlab.ui.control.EditField
        Hamso                       matlab.ui.control.EditField
        HocLabel                    matlab.ui.control.Label
        Dulieu_y                    matlab.ui.control.EditField
        Dulieu_x                    matlab.ui.control.EditField
    end

    % Callbacks that handle component events
    methods (Access = private)
    
        %CODE Ở ĐÂY
        % Button pushed function: Ketqua_button
        function Ketqua_buttonButtonPushed(app, event)

            % Chuyển input từ dạng text sang number
            x_val = str2double(app.Giatri_x.Value); %giá trị đạo hàm 
            h = str2double(app.Buocnhay_h.Value); %bước nhảy h
            
            method = app.PP_daoham.Value; % Lựa chọn pp để đạo hàm (tiến, lùi, tt)
            order = app.Saiso.Value;      % Chọn sai số 'O(h)' hoặc 'O(h^2)'
            
            % Chuyển hàm số từ Text -> Function 
            str_hamso = app.Hamso.Value;
            f = []; % Khởi tạo biến hàm số rỗng
            if ~isempty(str_hamso) %nếu người dùng có nhập ở hàm số
                try
                    f = str2func(['@(x) ' str_hamso]); %chuyển từ string to function
                catch
                    app.ketqua_result.Value = 'Lỗi cú pháp hàm số!'; %nếu lỗi định dạng func thì báo lỗi
                    return;
                end
            end
        
            % Chuyển mảng dữ liệu x, y từ Text -> mảng các số
            % Dùng str2num để chuyển chuỗi phân cách bằng dấu cách thành mảng số
            str_x = app.Dulieu_x.Value;
            str_y = app.Dulieu_y.Value;
            
            data_x = [];
            data_y = [];
            
            if ~isempty(str_x) && ~isempty(str_y)
                data_x = str2num(str_x);
                data_y = str2num(str_y); 
            end
            
            % --- PHẦN 2: TÍNH TOÁN (Calculation Logic) ---
            
            result = NaN; %tạo biến kết quả

            %---- ----
            if ~isempty(f) %nếu người dùng có nhập hàm số
                switch method
                    case 'Xấp xỉ tiến'
                        if strcmp(order, 'O(h)')
                            % Công thức tiến O(h): (f(x+h) - f(x)) / h
                            result = (f(x_val + h) - f(x_val)) / h;
                        else % O(h^2)
                            % Công thức tiến O(h^2): (-3f(x) + 4f(x+h) - f(x+2h)) / 2h
                            result = (-3*f(x_val) + 4*f(x_val + h) - f(x_val + 2*h)) / (2*h);
                        end
                        
                    case 'Xấp xỉ lùi'
                        if strcmp(order, 'O(h)')
                            % Công thức lùi O(h): (f(x) - f(x-h)) / h
                            result = (f(x_val) - f(x_val - h)) / h;
                        else % O(h^2)
                            % Công thức lùi O(h^2): (3f(x) - 4f(x-h) + f(x-2h)) / 2h
                            result = (3*f(x_val) - 4*f(x_val - h) + f(x_val - 2*h)) / (2*h);
                        end
                        
                    case 'Xấp xỉ trung tâm'
                        if strcmp(order, 'O(h)') % Nếu người dùng chọn O(h) thì Báo lỗi 
                            app.ketqua_result.Value = 'Lỗi: PP Trung tâm phải là O(h^2)!';
                            return; % thoát khỏi hàm, không chạy các dòng phía dưới nữa
                        else %nếu chọn O(h^2) thì tính bình thường
                            % Công thức trung tâm O(h^2): (f(x+h) - f(x-h)) / 2h
                            result = (f(x_val + h) - f(x_val - h)) / (2*h);
                        end
                end
                

            %--- ---
            % Nếu không nhập hàm số mà nhập MẢNG DỮ LIỆU
            elseif ~isempty(data_x) && ~isempty(data_y)
                % Kiểm tra xem giá trị x cần tính có nằm trong mảng x không
                idx = find(abs(data_x - x_val) < 1e-9, 1); 
                
                if isempty(idx) %nếu không có thì báo looix
                    app.ketqua_result.Value = 'Lỗi: Giá trị x phải nằm trong mảng x!';
                    return;
                end
                
                % Tính bước nhảy h từ mảng dữ liệu
                if length(data_x) > 1
                    h_calculated = data_x(2) - data_x(1);
                else
                    app.ketqua_result.Value = 'Lỗi: Mảng phải có ít nhất 2 phần tử!';
                    return;
                end
                
               %Tính 
                try
                    switch method
                        case 'Xấp xỉ tiến' 
                            if strcmp(order, 'O(h)')
                                % Công thức: (y(i+1) - y(i)) / h
                                result = (data_y(idx + 1) - data_y(idx)) / h_calculated;
                            else % O(h^2) 
                                % Công thức: (-y(i+2) + 4y(i+1) - 3y(i)) / 2h
                                result = (-data_y(idx + 2) + 4*data_y(idx + 1) - 3*data_y(idx)) / (2 * h_calculated);
                            end
                            
                        case 'Xấp xỉ lùi' 
                            if strcmp(order, 'O(h)')
                                % Công thức: (y(i) - y(i-1)) / h
                                result = (data_y(idx) - data_y(idx - 1)) / h_calculated;
                            else % O(h^2)
                                % Công thức: (3y(i) - 4y(i-1) + y(i-2)) / 2h
                                result = (3*data_y(idx) - 4*data_y(idx - 1) + data_y(idx - 2)) / (2 * h_calculated);
                            end
                            
                        case 'Xấp xỉ trung tâm' 
                            if strcmp(order, 'O(h)')
                                app.ketqua_result.Value = 'Lỗi: PP Trung tâm phải là O(h^2)!';
                                return;
                            else % O(h^2) 
                                % Công thức: (y(i+1) - y(i-1)) / 2h
                                result = (data_y(idx + 1) - data_y(idx - 1)) / (2 * h_calculated);
                            end
                    end
                    
                catch
                    % Báo lỗi nếu chỉ số vượt quá mảng (không có dữ liệu để
                    % tính 
                    app.ketqua_result.Value = 'Lỗi: Không đủ điểm dữ liệu để tính tại vị trí này!';
                    return;
                end
            else %nếu chưa nhập mảng x,y hay hàm số
                app.ketqua_result.Value = 'Vui lòng nhập Hàm số hoặc Dữ liệu!';
                return;
            end
            
            %--- HIỂN THỊ KẾT QUẢ  ---
            
            % Chuyển số thành chuỗi và hiện lên ô kết quả
            app.ketqua_result.Value = num2str(result);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Dulieu_x
            app.Dulieu_x = uieditfield(app.UIFigure, 'text');
            app.Dulieu_x.HorizontalAlignment = 'center';
            app.Dulieu_x.FontSize = 14;
            app.Dulieu_x.FontWeight = 'bold';
            app.Dulieu_x.FontColor = [0 0 0];
            app.Dulieu_x.Placeholder = 'Nhập dữ liệu x';
            app.Dulieu_x.Position = [63 362 202 31];

            % Create Dulieu_y
            app.Dulieu_y = uieditfield(app.UIFigure, 'text');
            app.Dulieu_y.HorizontalAlignment = 'center';
            app.Dulieu_y.FontSize = 14;
            app.Dulieu_y.FontWeight = 'bold';
            app.Dulieu_y.FontColor = [0 0 0];
            app.Dulieu_y.Placeholder = 'Nhập dữ liệu y';
            app.Dulieu_y.Position = [63 303 202 31];

            % Create HocLabel
            app.HocLabel = uilabel(app.UIFigure);
            app.HocLabel.HorizontalAlignment = 'center';
            app.HocLabel.FontSize = 14;
            app.HocLabel.FontWeight = 'bold';
            app.HocLabel.Position = [144 254 39 22];
            app.HocLabel.Text = 'Hoặc';

            % Create Hamso
            app.Hamso = uieditfield(app.UIFigure, 'text');
            app.Hamso.HorizontalAlignment = 'center';
            app.Hamso.FontSize = 14;
            app.Hamso.FontWeight = 'bold';
            app.Hamso.FontColor = [0 0 0];
            app.Hamso.Placeholder = 'Nhập hàm số';
            app.Hamso.Position = [63 203 202 31];

            % Create Buocnhay_h
            app.Buocnhay_h = uieditfield(app.UIFigure, 'text');
            app.Buocnhay_h.HorizontalAlignment = 'center';
            app.Buocnhay_h.FontSize = 14;
            app.Buocnhay_h.FontWeight = 'bold';
            app.Buocnhay_h.FontColor = [0 0 0];
            app.Buocnhay_h.Placeholder = 'Nhập bước nhảy h';
            app.Buocnhay_h.Position = [63 141 202 31];

            % Create Giatri_x
            app.Giatri_x = uieditfield(app.UIFigure, 'text');
            app.Giatri_x.HorizontalAlignment = 'center';
            app.Giatri_x.FontSize = 14;
            app.Giatri_x.FontWeight = 'bold';
            app.Giatri_x.FontColor = [0 0 0];
            app.Giatri_x.Placeholder = 'Nhập giá trị cần tính đạo hàm (số)';
            app.Giatri_x.Position = [360 275 245 31];

            % Create Ketqua_button
            app.Ketqua_button = uibutton(app.UIFigure, 'push');
            app.Ketqua_button.ButtonPushedFcn = createCallbackFcn(app, @Ketqua_buttonButtonPushed, true);
            app.Ketqua_button.FontSize = 14;
            app.Ketqua_button.FontWeight = 'bold';
            app.Ketqua_button.Position = [433 209 100 25];
            app.Ketqua_button.Text = 'Kêt quả';

            % Create ketqua_result
            app.ketqua_result = uieditfield(app.UIFigure, 'text');
            app.ketqua_result.Position = [360 141 245 31];

            % Create ChngitrsaisOhhocOh2DropDownLabel
            app.ChngitrsaisOhhocOh2DropDownLabel = uilabel(app.UIFigure);
            app.ChngitrsaisOhhocOh2DropDownLabel.HorizontalAlignment = 'right';
            app.ChngitrsaisOhhocOh2DropDownLabel.FontSize = 14;
            app.ChngitrsaisOhhocOh2DropDownLabel.FontWeight = 'bold';
            app.ChngitrsaisOhhocOh2DropDownLabel.Position = [41 84 246 26];
            app.ChngitrsaisOhhocOh2DropDownLabel.Text = 'Chọn giá trị sai số O(h) hoặc O(h^2)';

            % Create Saiso
            app.Saiso = uidropdown(app.UIFigure);
            app.Saiso.Items = {'O(h)', 'O(h^2)'};
            app.Saiso.Position = [63 60 202 25];
            app.Saiso.Value = 'O(h)';

            % Create ChnphngphpohmDropDownLabel
            app.ChnphngphpohmDropDownLabel = uilabel(app.UIFigure);
            app.ChnphngphpohmDropDownLabel.HorizontalAlignment = 'center';
            app.ChnphngphpohmDropDownLabel.FontSize = 14;
            app.ChnphngphpohmDropDownLabel.FontWeight = 'bold';
            app.ChnphngphpohmDropDownLabel.Position = [362 371 243 22];
            app.ChnphngphpohmDropDownLabel.Text = 'Chọn phương pháp đạo hàm';

            % Create PP_daoham
            app.PP_daoham = uidropdown(app.UIFigure);
            app.PP_daoham.Items = {'Xấp xỉ tiến', 'Xấp xỉ lùi', 'Xấp xỉ trung tâm'};
            app.PP_daoham.Position = [362 350 243 22];
            app.PP_daoham.Value = 'Xấp xỉ tiến';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Dao_ham

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end