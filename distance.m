function d = distance(inputcities)

d = 0; %Initialising 
for n = 1 : length(inputcities)
    if n == length(inputcities)
        d = d + ceil(sqrt(sum((inputcities(:,n) - inputcities(:,1)).^2)/10)); %Calculating distance from last city to first city
    else    
        d = d + ceil(sqrt(sum((inputcities(:,n) - inputcities(:,n+1)).^2)/10)); %Distance from all other cities until it reaches the last cities then other condition is used
    end
end

