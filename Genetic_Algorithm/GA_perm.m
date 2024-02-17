function [best_tour, best_distance] = GA_perm(inputcities, crossover_prob, max_pop, max_iter, mutation_prob, selection_method, k, mutation_type, eliteFraction, plot_graph)
    %fixed variables
    num_cities = size(inputcities,2);
    %%Default parameters if nothing is entered
    if nargin <10|| isempty(plot_graph)
    plot_graph = false;
    end
    %%Generating a random population
    pop = spawn_pop(max_pop,num_cities);
    numElites = max(1,round(eliteFraction * max_pop));


    termination = false;
    t = 1;
    while termination==false
        
        if selection_method==1
            parents = rank_selection(pop,max_pop,inputcities); %Ranked selection
     
        elseif selection_method==2

            parents = tournament_selection(pop,k,max_pop,inputcities);
        else
            error('Please select a correct selection method.')
            break
        end
  


        
        %%crossover
        offspring = parents;
        offspring_pop = zeros(max_pop*4 + ceil(max_pop*mutation_prob),num_cities); %%Calculating the maximum possible pre-allocated array to store mutations, mutations + crossover, crossover to allow for diversity
        performed_change = 0;
        for i = 1:max_pop-1
            p_crossover = rand();
            %Crossover if applicable
            if p_crossover <= crossover_prob
                performed_change = performed_change + 2; % increasing unchanged counter

                [child1, child2] = ox1(parents(i,:),parents(i+1,:));
                offspring = [child1;child2];
                offspring_pop(performed_change-1,:) = offspring(1,:);
                offspring_pop(performed_change,:) = offspring(2,:);
                
            end
            %Performing mutating
            p_mutate = rand();
            if p_mutate <= mutation_prob
                if mutation_type == 1
                    offspring = RSM(offspring);
                    parents_concat = [parents(i,:);parents(i+1,:)];
                    only_mutated = RSM(parents_concat);
                elseif mutation_type == 2
                    offspring = inversion_mutation(offspring);
                    parents_concat = [parents(i,:);parents(i+1,:)];
                    only_mutated = inversion_mutation(parents_concat);
                elseif mutation_type == 3
                    offspring = twoopt(offspring);
                    parents_concat = [parents(i,:);parents(i+1,:)];
                    only_mutated = twoopt(parents_concat);
                else
                    error('Please select a correct mutation method.')
                end
                performed_change = performed_change + 2;
                offspring_pop(performed_change-1,:) = offspring(1,:);
                offspring_pop(performed_change,:) = offspring(2,:);

                %%storing only mutated children
                performed_change = performed_change + 2;
                offspring_pop(performed_change-1,:) = only_mutated(1,:);
                offspring_pop(performed_change,:) = only_mutated(2,:);

            end
        end
        unfilled_rows = any(offspring_pop == 0, 2);
        offspring_pop(unfilled_rows, :) = [];

        temp_spring = [offspring_pop;pop];
        evaluate_dist = idx2dist(temp_spring,inputcities);
        [~, sorted_idx] = sort(evaluate_dist,'ascend');
        temp_spring = temp_spring(sorted_idx,:);


        eliteIndicies = sorted_idx(1:numElites);
        elites = temp_spring(eliteIndicies,:);
        shuffle = offspring_pop(randperm(size(offspring_pop,1)),:);
        [~, rowIndices] = ismember(temp_spring, elites, 'rows');
        missingRows = temp_spring(~rowIndices, :);
        pop = [elites;missingRows(1:end,:)];

        if size(pop,1) >= max_pop
            pop = pop(1:max_pop,:);
        else
            missing_diff = max_pop - size(pop,1);
            repair_pop = spawn_pop(missing_diff,num_cities);
            pop = [pop;repair_pop];

            %for i = 1:missing_diff
             
                %repair_pop = twoopt(pop);
                %scramble = randperm(size(repair_pop,1)); %%scrambling mutations to maintain diversity 
                %pop = [pop;repair_pop(scramble,:)]; %concatnating the mutations with current populations
        end
        pop = pop(1:max_pop,:); %limiting the population to maximum population



 


        best_tour = pop(1,:);
        best_distance = evaluate_fitness(pop,inputcities);
        
        if plot_graph == 1
            plotcities(inputcities(:,pop(1,:))); % plotting the best performer
        end



        t = t+1;


        if (t>max_iter)
            termination=true;
        end





    end

end

function [pop] = spawn_pop(num_pop,num_cities)
    pop = zeros([num_pop num_cities]);
    for i = 1:size(pop,1)
        pop(i,:) = randperm(num_cities);
    end
end

function [child_1, child_2] = ox1(parent_1, parent_2)

child_1 = zeros(size(parent_1));
child_2 = zeros(size(parent_2));
n = size(parent_1,2);
crossover_point = sort(randperm(n - 1,2));
child_1(crossover_point(1):crossover_point(2)) = parent_1(crossover_point(1):crossover_point(2));
child_2(crossover_point(1):crossover_point(2)) = parent_2(crossover_point(1):crossover_point(2));

i = crossover_point(2) + 1;
k = 1;
used = [parent_2(crossover_point(2)+1:n),parent_2(1:crossover_point(2))];
used(ismember(used,child_1)) = [];
while true 

    if i == crossover_point(1)
        break
    end
    child_1(i) = used(k);
    i = mod(i, n) + 1 ;
    k = k + 1;
  
end

i = crossover_point(2) + 1;
k = 1;
used = [parent_1(crossover_point(2)+1:n),parent_1(1:crossover_point(2))];
used(ismember(used,child_2)) = [];

while true 

    if i == crossover_point(1)
        break
    end
    child_2(i) = used(k);
    i = mod(i, n) + 1 ;
    k = k + 1;

end
end

function [dist] = idx2dist(index,inputcities)
dist = zeros(1,size(index,1));
for i = 1:size(index,1)
    dist(:,i) = distance(inputcities(:,index(i,:)));
end
end


function [best_distance, best_route] = evaluate_fitness(population,inputcities)
population_distances = idx2dist(population,inputcities);
[sorted_dist, sorted_idx] = sort(population_distances,"ascend");
best_distance = sorted_dist(1);
best_route = population(sorted_idx(1),:);
end
    

