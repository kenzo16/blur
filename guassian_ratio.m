
function [val] = guassian_ratio (value)
    val = gamma(1/value)*gamma(3/value)/(gamma(2/value))^2;
end