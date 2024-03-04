%Importing the coordinates for TSP
addpath('Genetic_Algorithm');
cities = "att48.tsp";
cities = tsp_read(cities,48); 
%%
%%Defining the search space for local random search
crossover_prob = [0.6;0.7;0.8;0.9];
max_population = [8;15;20;20];
max_iterations = linspace(10000,10000,4)';
mutation_prob = [0.1;0.2;0.3;0.4];
k = [5;4;4;4];
elitism_factor = [0.1;0.1;0.1;0.1];
tabs = table(crossover_prob,max_population,max_iterations,mutation_prob,k,elitism_factor);
acceleration = "multi";

%%
[hyperparams, distances] = main_random_local_search("ga",tabs,@GA_perm,cities,acceleration);
%%
combination = [hyperparams,distances'];
save('GA_tune.mat','combination')
  
%% We want low distance and low std, which implies robustness and high performing.

candidates = [];

for i = 1:size(combination,1)
    if combination(i,9)<11100
        candidates(end + 1) = i;
    end
end

%%
hyperparams(1,:)
%%
crossover_prob = 0.6;
pop_size = 15;
iterations = 10000/pop_size;
mutation_prob = 0.3;
k = 4;
elitism_factor = 0.1;
plots = false;
store = [];
for i = 1:30
    [~,b] = GA_perm(cities,crossover_prob,pop_size,iterations,mutation_prob,k,elitism_factor,plots);
    store(end + 1) = b
end
calculate_mean = mean(store);
calculate_std = std(store);
%%
crossover_prob = 0.6;
pop_size = 15;
iterations = 100000;
mutation_prob = 0.1;
k = 4;
elitism_factor = 0.1;
plots = false;
[a,b] = GA_perm(cities,crossover_prob,pop_size,iterations,mutation_prob,k,elitism_factor,plots);

