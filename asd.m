function [best_tour, best_distance] = asd(inputcities, crossover_prob, max_pop, max_iter, mutation_prob, selection_method, k, mutation_type, eliteFraction, plot_graph)
    %fixed variables
    num_cities = size(inputcities,2);
    %%Default parameters if nothing is entered
    if nargin <10|| isempty(plot_graph)
    plot_graph = false;
    end
    %%Generating a random population
    pop = spawn_pop(max_pop,num_cities);
    numElites = max(1,round(eliteFraction * max_pop));
    %%Evaluating the fitness of the population
    distancecache = containers.Map('KeyType','char','ValueType','any');
    %%
    routecache = containers.Map('KeyType','char','ValueType','any');
    [evaluated_pop_fitness] = evaluate_fitness(pop,inputcities,distancecache,routecache);

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
        for i = 1:max_pop-1
            p_crossover = rand();
            %Crossover if applicable
            if p_crossover > crossover_prob
                [child1, child2] = ox1(parents(i,:),parents(i+1,:));
                offspring(i,:) = child1;
                offspring(i+1,:) = child2;
            end
            %Performing mutating
            p_mutate = rand();
            if p_mutate > mutation_prob
                if mutation_type == 1
                    offspring(i,:) = RSM(offspring(i,:));
                    offspring(i+1,:) = RSM(offspring(i+1,:));
                elseif mutation_type == 2
                    offspring(i,:) = inversion_mutation(offspring(i,:));
                    offspring(i+1,:) = inversion_mutation(offspring(i+1,:));
                elseif mutation_type == 3
                    offspring(i,:) = twoopt(offspring(i,:));
                    offspring(i+1,:) = twoopt(offspring(i+1,:));
                else
                    error('Please select a correct mutation method.')
                end
            end
        end

        [evaluated_dist] = evaluate_fitness(offspring,inputcities,distancecache,routecache); %Evaluating the distances
        values = distancecache.values;
        numericValues = cellfun(@(x) x, values);
        [~, sortOrder] = sort(numericValues,"ascend");
        valuessa = routecache.values;
        
        sortedc = valuessa(sortOrder);

        eliteind = cell2mat(sortedc(1:numElites));
        random = randsample(numElites+1:size(valuessa,2), max_pop-numElites);
        select_individuals = cell2mat(sortedc(random)');
        pop = [eliteind;select_individuals];

        pop = pop(1:max_pop,:); %limiting the population to maximum population


 


        best_tour = pop(1,:);
        
        if plot_graph == 1
            plotcities(inputcities(:,pop(1,:))); % plotting the best performer
        end
        best_distance = idx2dist(pop(1,:),inputcities);



        t = t+1


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


function [evaluated_pop] = evaluate_fitness(population,inputcities,distancecache,routecache)
num_individuals = size(population,1);
evaluated_pop = zeros(1,num_individuals);
for i = 1:num_individuals
    routeKey = mat2str(population(i,:));
    if isKey(distancecache,routeKey)
        evaluated_pop(i) = distancecache(routeKey);
    else
        dist = idx2dist(population(i,:),inputcities);
        distancecache(routeKey) = dist;
        routecache(routeKey) = population(i,:);
        evaluated_pop(i) = dist;
    end
end
end


    

