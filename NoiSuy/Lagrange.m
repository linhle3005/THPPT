function result = Lagrange(xa, ya, x) 
    n = length(xa); 
    sum = 0; 
    if length(ya) ~= n
        error('Kích thước xa và ya phải bằng nhau');
    end
    for i = 1:n
        product = ones(size(x));
        for j = 1:n 
            if i ~= j 
                product = product.*(x - xa(j))/(xa(i) - xa(j)); 
            end 
        end
        sum = sum + ya(i)*product; 
    end
    result = sum; 
end  