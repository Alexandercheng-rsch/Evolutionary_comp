function [a,b,c] = main_random_local_search(type, varargin)

params = varargin{1};
func = varargin{2};
file = varargin{3};
accel = varargin{4};
switch type
    case 'sa'
        [a,b,c] = accelerated_local_search_sa(params, func, file, accel);
        
    case 'ga'
        
        [a, b, c] = accelerated_local_search_ga(params, func, file, accel);
    otherwise
        error('Unsupported operation type.');
end
end
