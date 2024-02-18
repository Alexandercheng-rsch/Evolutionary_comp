function [mean_lst,std_lst,groupedrows] = cluster_calculator(concated_list,mode)

if mode == 0
    %%grouping combinations
    [~,~,grouped_indicies] = unique(concated_list(:,1:8),'rows','stable'); % unique rows, with grouping index
    groupedrows = cell(max(grouped_indicies),1);
    for i = 1:max(grouped_indicies)
        groupedrows{i} = concated_list(grouped_indicies == i, :);
    end
    %%

    %%getting storing mean and std
    std_lst = cell(max(grouped_indicies),1);
    mean_lst = cell(max(grouped_indicies),1);
    %%
    n = size(groupedrows,1);%number of clusters
    for j = 1:n
        calculated_mean = mean(groupedrows{j});%Calculate mean
        calculated_std = std(groupedrows{j});%calculate std
        mean_lst{j} = calculated_mean(:,end);%storing mean
        std_lst{j} = calculated_std(:,end);%Storing std
    end
elseif mode == 1
    %%grouping combinations
    [~,~,grouped_indicies] = unique(concated_list(:,1:5),'rows','stable'); % unique rows, with grouping index
    groupedrows = cell(max(grouped_indicies),1);
    for i = 1:max(grouped_indicies)
        groupedrows{i} = concated_list(grouped_indicies == i, :);
    end
    %%

    %%getting storing mean and std
    std_lst = cell(max(grouped_indicies),1);
    mean_lst = cell(max(grouped_indicies),1);
    %%
    n = size(groupedrows,1);%number of clusters
    for j = 1:n
        calculated_mean = mean(groupedrows{j});%Calculate mean
        calculated_std = std(groupedrows{j});%calculate std
        mean_lst{j} = calculated_mean(:,end);%storing mean
        std_lst{j} = calculated_std(:,end);%Storing std  
    end
else
    error("Select a correct mode.")
end
end

