function [fitness best_tour] = GA_perm(inputcities)
%city variables
num_cities = length(inputcities)
%
%GA variables
crossover_prob = 0.6;
num_ind = 6; %no. solutions
mutation_prob = 1/num_cities;
max_iter = 500;
%%looping to make population matrix
pop = zeros([2,48,num_ind]);
inputcities_dup = repmat(inputcities,[1,1,num_ind]);
for i = 1:num_ind
    p = randperm(num_cities);
    pop(:,:,i) = inputcities_dup(:,p,i);
end

%%inital solutions
fitness = distance(pop);%getting fitness
num_parents = floor(num_ind * 0.3);

%


[sorted_fitness, sorted_idx] = sort(fitness, 'descend');




termination = false;
t = 1;
%

while termination==false

    parents = pop(:,:,num_parents);%truncation selection;
    offspring = parents;

    %%crossover
    for i = 1:floor(num_parents/2)
        if rand(1) < crossover_prob
            idx = randi([1 num_parents],2,1);
            cross_point = randi([1 num_cities]);
            offspring(:,cross_point+1,idx(1,:),:) = parents(:,cross_point+1,idx(2,:),:);
            offspring(:,cross_point+1,idx(2,:),:) = parents(:,cross_point+1,idx(1,:),:);
        end
    end
    %%mutation 
    for j = 1:num_cities
        if rand(1) < mutation_prob
            idx = randi(num_cities,1);
            offspring(:,idx,:) = parents(:,j,:);
        end
    end
    
    temp_pop = cat(3,pop,offspring);
    [fitness, idx] = sort(distance(temp_pop),'descend');
    pop = temp_pop(:,:,idx(1:num_ind));
    plotcities(pop(:,:,1))
    



    t = t+1;
    if t>max_iter
        termination=true;
end
best_tour = pop(:,:,1);

end




