function d = distance(input_cities)
d = zeros(1,size(input_cities,3))
z = 0
for j = 1:size(input_cities,3)
    for i = 2:length(input_cities)
        if i==length(input_cities) %trip back to original city

            z = z + ceil(sqrt(sum((input_cities(:,i,j) - input_cities(:,1,j)).^2)/10)); %Divide 10 for normalisation
        else
          
         z = z + ceil(sqrt(sum((input_cities(:,i,j) - input_cities(:,i+1,j)).^2)/10)); %Divide 10 for normalisation
         
      end
    end
    d(j) = z
end