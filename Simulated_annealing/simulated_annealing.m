function [x_best, e_best] = simulated_annealing(inputcities, temp_max, alpha, cooling_method, cooling_schedule,iterations,show_graph)
num_cities = size(inputcities,2);
if nargin<7 || isempty(show_graph)
    show_graph = false;
end
if nargin<6 || isempty(iterations)
    iterations = 0
end

x_current = randperm(num_cities); %Generate inital solution
e_current = idx2dist(x_current,inputcities); % Calculate objective function
x_best = x_current;
e_best = e_current;
maintain_temperature = 1;
temp_min = 1;
temp = temp_max;


if iterations==0
    use_iterations = false;
else
    use_iterations = true;
end

k = 1;
%%

while temp > temp_min


    p = rand(1);
    %%Looking for neighbours, different probabilities results in a
    %%different type of searching technique
    if p < 0.1
        x_new = twoopt(inversion_mutation(RSM(x_current)));
        e_new = idx2dist(x_new,inputcities);
   
    elseif (p < 0.1) & (p<0.33)
        x_new = RSM(x_current);
        e_new = idx2dist(x_new,inputcities);        
    elseif (p > 0.33) & (p<0.66)
        x_new = twoopt(x_current);
        e_new = idx2dist(x_new,inputcities);
    else
        x_new = inversion_mutation(x_current);
        e_new = idx2dist(x_new,inputcities);
    end
    acceptance_criterion = acceptance(temp, e_new, e_current);
    if acceptance_criterion == 1 
        x_current = x_new;
        e_current = e_new;
    end
    if e_current < e_best
        x_best = x_current;
        e_best = e_current;
    end

    if show_graph==1   
        plotcities(inputcities(:,x_best))
    end


    if cooling_method==1 && maintain_temperature == cooling_schedule %%how long is the heat maintained for
        temp = temp*alpha;
        maintain_temperature = 0;
    elseif cooling_method==2 && maintain_temperature == cooling_schedule 
        temp = temp/log(1+temp_max);
        maintain_temperature = 0;
    end

    if cooling_schedule>0
        maintain_temperature = maintain_temperature + 1;
    end

    k = k + 1;

    if (use_iterations) & (k == iterations)
        break
    end


end
end








 