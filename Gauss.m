function x = Gauss(A,b)
Ab = [A b];
n = length(A);
nb = n+1;
% Quá trình thuận:
% chuẩn hóa hệ số các phần tử trên đường chéo thành 1
% khử các phần tử bên dưới đường chéo thành 0
for i = 1:n-1
    for j = i+1:n
        Ab(j,i:nb) = Ab(j,i:nb)-Ab(j,i)*Ab(i,i:nb)/Ab(i,i);
    end
end
% Quá trình ngược:
% tìm nghiệm pt cuối cùng và thế ngược lên trên để tính các nghiệm còn lại
x = zeros(n,1);
x(n) = Ab(n,nb)/Ab(n,n);
for i = n-1:-1:1
    x(i) = (Ab(i,nb)-Ab(i,i+1:n)*x(i+1:n))/Ab(i,i);
end