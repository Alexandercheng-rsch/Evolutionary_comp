function [boolean] = acceptance(temp, e_new ,e_current)
delta_E = e_new - e_current;
if delta_E < 0 
    boolean = true;
else
    r = rand(1);
    if r < exp(-delta_E/temp);
        boolean = true;
    else
        boolean = false;
    end
end
end


