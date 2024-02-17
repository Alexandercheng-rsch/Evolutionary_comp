function winners = tournament_selection(pop, k, max_pop, inputcities)
    n = size(pop,1);  % Number of individuals in the population
    winners = zeros(max_pop, size(pop,2));  % Preallocate winners matrix

    for j = 1:max_pop
        % Randomly select an initial individual as the 'best' for the tournament
        bestIdx = randperm(n, 1);
        best = pop(bestIdx, :);
        bestDist = idx2dist(best, inputcities);  % Calculate its distance only once

        for i = 2:k
            % Randomly select another participant for the tournament
            participantIdx = randperm(n, 1);
            participant = pop(participantIdx, :);

            % Calculate the distance for the participant and compare with the best
            participantDist = idx2dist(participant, inputcities);
            if participantDist < bestDist
                best = participant;
                bestDist = participantDist;  % Update the best distance
            end
        end

        % Assign the tournament winner to the winners matrix
        winners(j,:) = best;
    end
end
