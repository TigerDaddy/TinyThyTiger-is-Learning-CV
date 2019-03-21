clear all; close all; clc;

img=double(imread('lena.jpg'));
[width height]=size(img);

w=1/256*[1  4  6  4 1;      %拉普拉斯滤波器
         4 16 24 16 4;
         6 24 36 24 6;
         4 16 24 16 4;
         1  4  6  4 1];

pyramid{1}=img;
for i=1:4                   %滤波，下采样
   pyramid{i+1}=imfilter(pyramid{i},w,'replicate');
   pyramid{i+1}=pyramid{i+1}(1:2:size(pyramid{i},1)-1,1:2:size(pyramid{i},2)-1);
end
  
for i=4:-1:1        %调整图像尺寸
    pyramid{i}=pyramid{i}(1:2*size(pyramid{i+1},1),1:2*size(pyramid{i+1},2)); 
end

for i=1:1:4
    figure('NumberTitle', 'off', 'Name', ['金字塔第',i,'层']);
    imshow(uint8(pyramid{i}));
end

for i=1:3          %获得残差图像
    expd{i}=expand(pyramid{i+1},w);
    residual{i}=pyramid{i}-expd{i};
end

  
figure('NumberTitle', 'off', 'Name', '单层上采样结果');
imshow(uint8(expd{1}));
figure('NumberTitle', 'off', 'Name', '单层残差');
imshow(uint8(residual{1}));

for i=3:-1:1        %残差图像重构原图像
    reconstruct{i}=expd{i}+residual{i};
end

figure('NumberTitle', 'off', 'Name', '单层重建结果');
imshow(uint8(reconstruct{1}));
