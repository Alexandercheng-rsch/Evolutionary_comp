function [mutated] = RSM(parents)
n = size(parents,2);
mutated = parents;

for i = 1:size(parents,1)
    idx = sort(randperm(n,2));
    target = parents(i,idx(1):idx(2));
    flipped = fliplr(target);
    mutated(i,:) = [parents(i,1:idx(1)-1),flipped,parents(i,idx(2)+1:n)];
end











