function [ gamma, stddev ] = feature_extract2( values )

    %%INPUT IS A 1D Array
    %%STEP 1
    mu = mean(values(:));
    variance = var(values(:));
    
    
    %%STEP 2
    [M temp] = size(values(:));
    temp = abs(values - mu);
    mod_mu = (1/M)*sum(temp(:));
    
    %%STEP 3
    ratio = variance/mod_mu^2;
    
    %%STEP 4
    load('lookupTable.mat');
    tolerance = 0.0001;
    [len temp] = size(val); 
    for i = 1 : len
        gauss = val(i,1);
        shape = val(i,2);
        if  abs(gauss-ratio) < tolerance || gauss < ratio 
            break;
        end
    end

    %%RETURN VALUES
    gamma = shape;
    stddev = sqrt(variance);
    
    save('values.mat');
    
    
end
