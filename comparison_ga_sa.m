addpath('Genetic_Algorithm\');
addpath('Simulated_annealing\')
cities = "att48.tsp";
cities = tsp_read(cities,48); 
%%
%Genetic algorithm
crossover_prob = 0.95;
pop_size = 20;
iterations = 10000/pop_size;
mutation_prob = 0.05;
selection_method = 1;
k = 7;
mutation_type = 1;
elitism_factor = 0.0775 ;
plots = false;
ga_distances = [];
for i = 1:30
    [~,distance] = GA_perm(cities,crossover_prob,pop_size,iterations,mutation_prob,selection_method,k,mutation_type,elitism_factor,plots);
    ga_distances(end + 1) = distance;
end
calculate_mean = mean(ga_distances);
calculate_std = std(ga_distances);
%%
%%
t_max = 100;
alpha = 0.99;
cooling_technique = 1;
cooling_schedule = 700;
iterations = 10000;
show_graph = false
sa_distances = [];
for i = 1:30
    [~,best_dist] = simulated_annealing(cities,t_max,alpha,cooling_technique,cooling_schedule,iterations,show_graph);
    sa_distances(end + 1) = best_dist;
end
calculate_mean = mean(sa_distances);
calculate_std = std(sa_distances);
%%
%%Wilcoxon signed rank test
[p,h,status] = signrank(ga_distances,sa_distances);

%%H_0 = There is no difference between the mean of the GA & SA
%%H_1 = There is a difference between the mean of the GA & SA
%% p = 1.7344e-06, therefore we reject the null and accept the alternative hypothesis at the 5% significance level. since p < 0.05


