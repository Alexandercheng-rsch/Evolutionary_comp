%Importing the coordinates for TSP
addpath('Genetic_Algorithm');
file = "att48.tsp";
file = tsp_read(file,48); 
%%
%%Defining the search space for local random search
crossover_prob = [0.7:0.06:1]';
max_population = [9;10;13;15;17;20];
max_iterations = [100;100;100;100;100;100];
mutation_prob = [0.05:0.03:0.2]';
selection_method = [1;2;1;1;1;1;];
k = [3;4;5;6;7;8];
mutation_type = [1;2;3;1;1;1];
elitism_factor = [0.03:0.012:0.1]'
tabs = table(crossover_prob,max_population,max_iterations,mutation_prob,selection_method,k,mutation_type,elitism_factor);
acceleration = "cuda";

%%
store = [];
n = 5
for i = 1:n
    tic
    [b,c] = main_random_local_search("ga",tabs,@GA_perm,file,acceleration);
    toc
    combo_cat_with_dist_1 = cat(2,b,c);
    store = [store;combo_cat_with_dist_1];
end

%%
mode = 0
[mean_elements,std_elements, clusters] = cluster_calculator(store,mode);

mean_elements = cell2mat(mean_elements);
std_elements = cell2mat(std_elements);
%%
clusters{27}
  
%% We want low distance and low std, which implies robustness and high performing.

candidates = [];

for i = 1:length(mean_elements)
    if mean_elements(i)<13400 && std_elements(i)<100
        candidates(end + 1) = i;
    end
end
candidates
%%

%%
[a,b] = sort(all);
asd = candidates(b)
asd(1:5)
%%
clusters{1699}
%%
crossover_prob = 0.88;
pop_size = 20;
iterations = 10000/pop_size;
mutation_prob = 0.17;
selection_method = 1;
k = 5;
mutation_type = 2;
elitism_factor = 0.078;
plots = false;
store = [];
for i = 1:30
    [~,b] = GA_perm(file,crossover_prob,pop_size,iterations,mutation_prob,selection_method,k,mutation_type,elitism_factor,plots);
    store(end + 1) = b
end
calculate_mean = mean(store);
calculate_std = std(store);
%%











%%
%%inputcities,inital_temp,constant_decrement,k_max,num_neighbours,alpha,cooling_schedule,show_graph
addpath('Simulated_annealing');

%%
repmat(100,10)
inital_temp = linspace(1,12, 20)';
k_max = repmat(100,1,20)';
alpha = linspace(0.8, 0.99, 20)';
cooling_technique = repmat([1 2],1,10)';
cooling_schedule = round(linspace(0, 20, 20))';
acceptance_prob = linspace(0.8,0.99,20)';
%(inputcities,inital_temp,k_max,alpha,cooling_method,cooling_schedule,acceptance_prob,show_graph)
params = table(inital_temp,k_max,alpha,cooling_technique,cooling_schedule,acceptance_prob);
acceleration = "multi";
store = []
for i = 1:5
    [hyperparam, dist] = main_random_local_search("sa",params,@simulated_annealing,file,acceleration);
    combo_cat_with_dist_1 = cat(2,hyperparam,dist);
    store = [store;combo_cat_with_dist_1];
end
save('asdasda.mat', 'store');
%%
mode = 1;
[mean_elements,std_elements, clusters] = cluster_calculator(store,mode);

mean_elements = cell2mat(mean_elements);
std_elements = cell2mat(std_elements);

%% We want low distance and low std, which implies robustness and high performing.

candidates = [];

for i = 1:length(mean_elements)
    if mean_elements(i)<27100 && std_elements(i)<3000
        candidates(end + 1) = i;
    end
end
candidates
%%
clusters{111}
%%
inital_t = 1;
k_max = 10000;
cooling_technique = 1;
alpha = 0.963636363636364 ;
show_graph = false;
cooling_schedule = 8.42105263157895;
acceptance_prob = 0.726363636363636
store_sa = []
for i = 1:30
    [~,best_dist] = simulated_annealing(file,inital_t,k_max,alpha,cooling_technique,cooling_schedule,acceptance_prob,show_graph);
    store_sa(end + 1) = best_dist
end
calculate_mean = mean(store_sa);
calculate_std = std(store_sa);
%%
inital_t = 1;
k_max = 10000;
cooling_technique = 2;
alpha = 0.828888888888889;
show_graph = false;
cooling_schedule = 180;
acceptance_prob = 0.9
[~,best_dist] = simulated_annealing(file,inital_t,k_max,alpha,cooling_technique,cooling_schedule,acceptance_prob,show_graph)






