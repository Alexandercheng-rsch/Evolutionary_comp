function [fitness best_tour] = GA_perm(inputcities)
%city variables
num_cities = length(inputcities)
%
%GA variables
crossover_prob = 0.6;
num_ind = 5; %no. solutions
mutation_prob = 1/num_cities;
%%looping to make population matrix
pop = zeros([2,48,5])
inputcities_dup = repmat(inputcities,[1,1,5])
for i = 1:5
    p = randperm(num_cities)
    pop(:,:,i) = inputcities_dup(:,p,i)
end

%%inital solutions
fitness = distance(pop);%getting fitness
num_parents = floor(num_ind * 0.3);

%


[sorted_fitness, sorted_idx] = sort(fitness, 'descend');




termination = false;
t = 1;
%

while termination==false;

    parents = pop(:,:,num_parents)%truncation selection;
    offspring = parents;

end




