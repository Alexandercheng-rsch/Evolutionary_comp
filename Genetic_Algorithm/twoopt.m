function [newroutes] = twoopt(route)


n = size(route,1);%Number of neighbours
m = size(route,2); %Number of cities
newroutes = zeros(n,m);%Preallocation 
for i = 1:n
    idx = sort(randsample([2:m-1],2));%Ensuring it's from smallest to largest
    newroutes(i,:) = [route(i,1:idx(1)-1),fliplr(route(i,idx(1):idx(2))),route(i,idx(2)+1:end)];%Reverses the chromosomes between the two pivot points and places it back.
end
end


