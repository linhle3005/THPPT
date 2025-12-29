function P = NewtonSymbolic(xa, ya)
    syms x
    n = length(xa);
    dd = zeros(n, n); 
    dd(:,1) = ya(:);
    for j = 2:n
        for i = j:n
            dd(i,j) = (dd(i,j-1) - dd(i-1,j-1)) / (xa(i) - xa(i-j+1));
        end
    end
    P = dd(1,1);
    term = 1;
    for j = 2:n
        term = term * (x - xa(j-1));
        P = P + dd(j,j) * term;
    end
    P = expand(P); 
end
