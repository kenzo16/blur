
I = (imread('asd.jpg'));

H = fspecial('motion',5,45);
pic = imfilter(I,H,'replicate');


figure;imshow(pic);
H = fspecial('disk',4);
pic = imfilter(I,H,'replicate');
figure;imshow(pic);