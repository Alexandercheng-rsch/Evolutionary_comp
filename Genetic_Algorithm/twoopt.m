function [newroutes] = twoopt(route)


n = size(route,1);
m = size(route,2);
newroutes = zeros(n,m);
for i = 1:n
    idx = sort(randperm(m,2));
    newroutes(i,:) = [route(i,1:idx(1)-1),fliplr(route(i,idx(1):idx(2))),route(i,idx(2)+1:end)];
end
end


