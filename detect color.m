P = imread('pfizer1.jpg');

G = rgb2gray(P);
A = P(:,:,1);
F = imsubtract(A,G);
F = im2bw(F, 0.18);

subplot(2,2,1);imshow(P);
subplot(2,2,2);imshow(G);
subplot(2,2,3);imshow(A);
subplot(2,2,4);imshow(F);