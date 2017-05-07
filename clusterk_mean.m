load('extracted_vals.mat');
load('currentImage');
X = 0;


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

[idx c] = kmeans(V(:),2);
V
[a b] = size(gamma_val);
V = 0;
count =1;
for j = 1 : b
    for  i = 1 : a
        if idx(count) ==1
            V(i,j) = 'M';
        else
            V(i,j) = 'O';
        end
        count = count + 1;
    end
end

finalpic = dispImage(V, rgb2gray(imread(image)));
imshow(finalpic);

