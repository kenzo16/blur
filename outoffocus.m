
count = 1;
load('dataset_O.mat');
[len a] = size(dataset);
oldset = dataset;
dataset =0;
for i = 1:len
    if oldset(i,1) < 0.28
        dataset(count,1) = oldset(i,1);
        dataset(count,2) = oldset(i,2);
        dataset(count,3) = oldset(i,3);
        count = count +1;
    end
end
count
save('dataset_O.mat','dataset');
    
   