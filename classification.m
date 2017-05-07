% New feature Vi,j by combining b gamma and sigma
%Evaluating w for threshold from the dataset
classifier


load('W.mat');
load('extracted_vals.mat');
load('currentImage');
[a,b] = size(gamma_val);

w = w';
V = zeros(1,1);


%evalutaion Vi,j for each gamma and sigma
for i = 1:a
    for j = 1:b
        V(i,j) = w * [gamma_val(i,j) , sigma_val(i,j)]';
    end
end
V
%Finding Threshold
findThreshold

%loading Threshold from training data
load('threshold.mat');
[a,b] = size(gamma_val);
%Classify with threshold

for i = 1:a
    for j = 1:b
        if V(i,j) <= threshold 
            K(i,j) = 'M';
        else
            K(i,j) = 'O';
        end
    end
end

%Display final Image
finalpic = dispImage(K, rgb2gray(imread(image)));
imshow(finalpic);