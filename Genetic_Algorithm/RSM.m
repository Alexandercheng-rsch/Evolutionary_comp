function [mutated] = RSM(parents)
n = size(parents,2); % Getting length of chromosome
mutated = parents; % Defining output

for i = 1:size(parents,1) %Iterating through the stack of different chromosomes
    idx = sort(randperm(n,2));  %%randomly choosing points
    target = parents(i,idx(1):idx(2)); %Defining subset
    flipped = fliplr(target);%Inversing subset of chromosome
    mutated(i,:) = [parents(i,1:idx(1)-1),flipped,parents(i,idx(2)+1:n)]; %%Grafting back the modified chromosome
end











