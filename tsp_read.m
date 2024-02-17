%%%%%
%Read me
%only need to state the file dir for the code to function
%will probably break if a different code .tsp file is used
%depends if the format is the same.
%%%%%
function stuff = tsp_read(tsp_file,cities)
    tsp_open = fopen(tsp_file,'r');
    stuff = zeros(2,cities); %%how many cities?
    tline = fgetl(tsp_open);
    startCollecting = false;
    while ischar(tline)
     if strcmp(tline,'NODE_COORD_SECTION')
            startCollecting = true; 
        elseif strcmp(tline,'EOF')
            startCollecting = false; %closure
        elseif startCollecting %start collecting
            splitLine = textscan(tline, '%d'); %read only int
            stuff(1,splitLine{1}(1)) = splitLine{1}(2);%extracting 1
            stuff(2,splitLine{1}(1)) = splitLine{1}(3);%extracting 2
     end

        tline = fgetl(tsp_open);
    end

    fclose(tsp_open) %close file to save resources
end


