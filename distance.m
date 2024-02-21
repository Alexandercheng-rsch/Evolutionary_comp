function d = distance(inputcities)

d = 0;
for n = 1 : length(inputcities)
    if n == length(inputcities)
        d = d + sqrt(sum((inputcities(:,n) - inputcities(:,1)).^2));
    else    
        d = d + sqrt(sum((inputcities(:,n) - inputcities(:,n+1)).^2));
    end
end

