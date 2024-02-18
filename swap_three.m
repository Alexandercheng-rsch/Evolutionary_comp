function city = swap_three(city,n)
    ind1 = 0; ind2 = 0; ind3 = 0;
    while (ind1 == ind2) || (ind1 == ind3) ...
            || (ind2 == ind3) || (abs(ind1-ind2) == 1)
        ind1 = ceil(rand.*n);
        ind2 = ceil(rand.*n);
        ind3 = ceil(rand.*n);
    end
    tmp1 = ind1;tmp2 = ind2;tmp3 = ind3;
    % È·±£ind1 < ind2 < ind3
    if (ind1 < ind2) && (ind2 < ind3)
        ;
    elseif (ind1 < ind3) && (ind3 < ind2)
        ind2 = tmp3;ind3 = tmp2;
    elseif (ind2 < ind1) && (ind1 < ind3)
        ind1 = tmp2;ind2 = tmp1;
    elseif (ind2 < ind3) && (ind3 < ind1)
        ind1 = tmp2;ind2 = tmp3; ind3 = tmp1;
    elseif (ind3 < ind1) && (ind1 < ind2)
        ind1 = tmp3;ind2 = tmp1; ind3 = tmp2;
    elseif (ind3 < ind2) && (ind2 < ind1)
        ind1 = tmp3;ind2 = tmp2; ind3 = tmp1;
    end
    tmplist1 = city((ind1+1):(ind2-1),:);
    city((ind1+1):(ind1+ind3-ind2+1),:) = ...
        city((ind2):(ind3),:);
    city((ind1+ind3-ind2+2):ind3,:) = ...
        tmplist1;
end


%     points = randi(n,1,3);
% %     while ~all(diff(points))
% %     while size(unique(points),1) == n
% %         points = randi(n,1,3);
% %     end
%     while size(unique(points),2) < 3
%         points = randi(n,1,3);
%     end
%     points = sort(points);
%     city_temp = city; % ???a+1>b-1?
% 1):(points(1)-1+points(3)-points(2)),:)= ...
%                 city_temp((points(2)+1
%         city(points():points(3),:);
%         city((points(1)+points(3)-points(2)):(points(3)),:)= ...
%                 city_temp(points(1):points(2),:);
%     for i = 1:(points(3)-points(2))
%         city(points(1)-1+i,:)= city_temp(points(2)+i,:);
%     end
%     for i = 1:(points(2)-points(1)+1)
%         city(points(1)+points(3)-points(2)-1+i,:) = city_temp(points(1)+i-1,:);
%     end