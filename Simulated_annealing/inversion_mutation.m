function mutated_tour = inversion_mutation(parents)
n = size(parents,2);

mutated_tour = parents;
for j = 1:size(parents,1)
    pos = randperm(n,2);
    p = rand(1);
    if pos(1)>pos(2)
        pos_1 = pos(2);
        pos_2 = pos(1);
    else
        pos_1 = pos(1);
        pos_2 = pos(2);
    end
    while pos_1 < pos_2
        temp = mutated_tour(j,pos_1);
        mutated_tour(j,pos_1) = mutated_tour(j,pos_2);
        mutated_tour(j,pos_2) = temp;
        pos_1 = pos_1 + 1;
        pos_2 = pos_2 - 1;
    end
end
end


