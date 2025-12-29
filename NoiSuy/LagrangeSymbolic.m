function P = LagrangeSymbolic(xa, ya)
    syms x;           
    n = length(xa);   
    P = 0;            
    for i = 1:n
        Li = 1;
        for j = 1:n
            if i ~= j
                Li = Li * (x - xa(j)) / (xa(i) - xa(j));
            end
        end
        P = P + ya(i) * Li;
    end
    P = expand(P);
end