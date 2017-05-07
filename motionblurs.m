
I = (imread('pen.jpg'));

H = fspecial('motion',4,45);
pic = imfilter(I,H,'replicate');


figure;imshow(pic);
H = fspecial('disk',4);
pic = imfilter(I,H,'replicate');
figure;imshow(pic);