
%asd = concat


% Initialize a container map to hold clusters
clusters = containers.Map('KeyType', 'char', 'ValueType', 'any');
myCellArray = cell(1, size(asd,1));
for i = 1:size(asd,1)
    % Create a unique key for each row based on the first 7 elements
    key = join(string(asd(i, 1:7)), '_');
    myCellArray(i) = [key]

    % Check if the key exists in the map
    if isKey(clusters, key)
        % Append the row to the existing cluster
        clusters(key) = [clusters(key); asd(i, :)];
    else
        % Create a new cluster with this row
        clusters(key) = asd(i, :);
    end
end

% Optionally, convert the clusters back to a more usable form
clusteredCells = values(clusters);
