% New feature Vi,j by combining b gamma and sigma
load('W.mat');
load('extracted_vals.mat');
[a,b] = size(gamma_val);
w = w';
V = zeros(1,1);

for i = 1:a
    for j = 1:b
        V(i,j) = w * [gamma_val(i,j) , sigma_val(i,j)]';
    end
end

