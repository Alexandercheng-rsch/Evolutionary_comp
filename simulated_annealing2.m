function [x_best, best_distance] = simulated_annealing2(inputcities, target_acceptance_rate, initial_temp_guess, constant_decrement, k_max, num_neighbours, alpha, cooling_method, cooling_schedule, show_graph)

% Initialize the number of cities and the initial solution
num_cities = size(inputcities,2);
x_current = randperm(num_cities);
e_current = idx2dist(x_current, inputcities);
x_best = x_current;
e_best = e_current;

% Initialize parameters for the temperature optimization phase
temp = initial_temp_guess; % Start with a guessed initial temperature
max_temp_trials = 10000; % Maximum number of trials to find the optimal initial temperature
desired_acceptance_rate = target_acceptance_rate; % Target acceptance rate for worse solutions

% Temperature optimization loop
acceptance_rate = 0;
trial = 0;
while acceptance_rate < desired_acceptance_rate && trial < max_temp_trials
    worse_accepted = 0;
    worse_attempted = 0;
    
    for i = 1:num_neighbours
        x_trial = twoopt(x_current, 0, 'sa');
        e_trial = idx2dist(x_trial, inputcities);
        
        if e_trial > e_current
            worse_attempted = worse_attempted + 1;
            delta_e = e_trial - e_current;
            if exp(-delta_e / temp) > rand()
                worse_accepted = worse_accepted + 1;
            end
        end
    end
    
    if worse_attempted > 0
        acceptance_rate = worse_accepted / worse_attempted;
    else
        acceptance_rate = 0;
    end
    
    temp = temp * 1.1 % Increase temperature by 10% for the next trial
    trial = trial + 1;
end

% Check if the optimal temperature was found
if acceptance_rate < desired_acceptance_rate
    error('Failed to find suitable initial temperature within the given number of trials.');
end

% Main simulated annealing loop using the optimized initial temperature
k = 1; % Initialize iteration counter
maintain_heat = 0; % Initialize heat maintenance counter
while k < k_max
    neighbours = zeros(num_neighbours,num_cities);
    algorithm = "sa";
    for j = 1:num_neighbours
        neighbours(j,:) = twoopt(x_current,0,algorithm);
    end
    a = randperm(5,1);
    [e_new, idx] = sort(idx2dist(neighbours,inputcities),'ascend');
    e_new = e_new(:,a);
    x_new = neighbours(idx(a),:);
    if e_new < e_current
        x_current = x_new;
        e_current = e_new;
        if e_new < e_best
            x_best = x_new;
            e_best = e_new;
        end
    else
        prob = exp(-(e_current-e_new)/temp);
        if rand > prob
            x_current = x_new;
        end
    end

    if show_graph==1   
        plotcities(inputcities(:,x_best)); 
    end
    
    if cooling_method==1 && maintain_heat == cooling_schedule %%how long is the heat maintained for
        temp = temp*alpha; 
        maintain_heat = 0;
    elseif cooling_method==2 && maintain_heat == cooling_schedule
        temp = max(temp - constant_decrement,0);
        maintain_heat = 0;
    elseif cooling_method==3 && maintain_heat == cooling_schedule 
        temp = inital_temp/log(1+k);
        maintain_heat = 0;
    end
    if maintain_heat>0
        maintain_heat = maintain_heat + 1;
    end

    k = k + 1 % Increment iteration counter

end

% Calculate the best distance
best_distance = idx2dist(x_best, inputcities);
end
