function d = distance(input_cities)
d = 0;
for i = 2:length(input_cities)
    if i==length(input_cities) %trip back to original city
        d = d + ceil(sum(sqrt((input_cities(:,i) - input_cities(:,1))^2)/10)); %Divide 10 for normalisation
    else
        d = d + ceil(sum(sqrt((input_cities(:,i) - input_cities(:,i+1))^2)/10)); %Divide 10 for normalisation
    end
end