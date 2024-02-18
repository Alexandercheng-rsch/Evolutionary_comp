function [dist] = idx2dist(index,inputcities)
dist = [];
for i = 1:size(index,1)
    dist(end + 1) = distance(inputcities(:,index(i,:)));
end
end