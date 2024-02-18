function [x_best, best_distance] = simulated_annealing(inputcities,inital_temp,k_max,alpha,cooling_method,cooling_schedule,acceptance_prob,show_graph)
num_cities = size(inputcities,2);
if nargin<8 || isempty(show_graph)
    show_graph = false;
end


%%
num_cities = size(inputcities,2);
x_current = randperm(num_cities); %Generate inital solution
e_current = idx2dist(x_current,inputcities); % Calculate objective function
x_best = x_current;
e_best = e_current;
temp = inital_temp;
%%
k = 1; %initiate counter
maintain_heat = 0; %Setting the counter for how long each temperature is held for
%%Predicting the temperature
%%A trial run
average = zeros(1,1000);
for i = 1:k_max
    p = rand(1);
    %%Looking for neighbours, different probabilities results in a
    %%different type of searching technique
    if p<= 0.1
        x_new = twoopt(inversion_mutation(RSM(twoopt(x_current))));
        e_new = idx2dist(x_new,inputcities);
    elseif p > 0.1 && p <= 0.3
        x_new = twoopt(x_current);
        e_new = idx2dist(x_new,inputcities);        
    elseif p>0.3 && p<0.6
        x_new = RSM(x_current);
        e_new = idx2dist(x_new,inputcities);
    elseif p >= 0.6 && p < 0.65
        x_new = twoopt(inversion_mutation(x_current));
        e_new = idx2dist(x_new,inputcities);
    elseif p > 0.65
        x_new = inversion_mutation(x_current);
        e_new = idx2dist(x_new,inputcities); 
    end
    
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
    average(i) = e_new - e_current; %%The change in energy
end
delta_e = mean(average(average ~= 0)); %Averaging the change in energy
temp = inital_temp;
j = exp(-(delta_e/temp));
while j < acceptance_prob %% Ensures worst moves fall within acceptance %
    j = exp(-delta_e/temp);
    temp = temp + 0.2;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Main part of the SA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%algorithm%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Reinitiating the parameters
x_current = randperm(num_cities); %Generate inital solution
e_current = idx2dist(x_current,inputcities); % Calculate objective function
x_best = x_current;
e_best = e_current;
k = 1;
%%

while k < k_max 

    p = rand(1);
    %%Looking for neighbours, different probabilities results in a
    %%different type of searching technique
    if p<= 0.1
        x_new = twoopt(inversion_mutation(RSM(twoopt(x_current)))); %%Big perturbation 
        e_new = idx2dist(x_new,inputcities);
    elseif p > 0.1 && p <= 0.3
        x_new = twoopt(x_current);
        e_new = idx2dist(x_new,inputcities);        
    elseif p>0.3 && p<0.6
        x_new = RSM(x_current);
        e_new = idx2dist(x_new,inputcities);
    elseif p >= 0.6 && p < 0.65
        x_new = twoopt(inversion_mutation(x_current));
        e_new = idx2dist(x_new,inputcities);
    elseif p > 0.65
        x_new = inversion_mutation(x_current);
        e_new = idx2dist(x_new,inputcities); 
    end
    
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
        plotcities(inputcities(:,x_current)); 
    end

    
    if cooling_method==1 && maintain_heat == cooling_schedule %%how long is the heat maintained for
        temp = temp*alpha;
        maintain_heat = 0;
    elseif cooling_method==2 && maintain_heat == cooling_schedule 
        temp = inital_temp/log(1+k);
        maintain_heat = 0;
    end
    if cooling_schedule>0
        maintain_heat = maintain_heat + 1;
    end
    k = k+1;




end
best_distance = idx2dist(x_best,inputcities);
end








 