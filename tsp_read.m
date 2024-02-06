function stuff = tsp_read(tsp_file,cities)
    tsp_open = fopen(tsp_file,'r')
    stuff = zeros(2,cities) %%how many cities?
    tline = fgetl(tsp_open);
    startCollecting = false;
    iter = 0 %count
    while ischar(tline)
     if strcmp(tline,'NODE_COORD_SECTION')
            startCollecting = true; 
        elseif strcmp(tline,'EOF')
            startCollecting = false; %closure
        elseif startCollecting %start collecting
            iter = iter + 1 
            splitLine = textscan(tline, '%d'); %read only int
            stuff(1,splitLine{1}(1)) = splitLine{1}(2)%extracting 1
            stuff(2,splitLine{1}(1)) = splitLine{1}(3)%extracting 2
     end

        tline = fgetl(tsp_open);
    end

    fclose(tsp_open)
end


