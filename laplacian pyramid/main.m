clear all; close all; clc;

img=double(imread('lena.jpg'));
[width height]=size(img);

w=1/256*[1  4  6  4 1;      %������˹�˲���
         4 16 24 16 4;
         6 24 36 24 6;
         4 16 24 16 4;
         1  4  6  4 1];

pyramid{1}=img;
for i=1:4                   %�˲����²���
   pyramid{i+1}=imfilter(pyramid{i},w,'replicate');
   pyramid{i+1}=pyramid{i+1}(1:2:size(pyramid{i},1)-1,1:2:size(pyramid{i},2)-1);
end
  
for i=4:-1:1        %����ͼ��ߴ�
    pyramid{i}=pyramid{i}(1:2*size(pyramid{i+1},1),1:2*size(pyramid{i+1},2)); 
end

for i=1:1:4
    figure('NumberTitle', 'off', 'Name', ['��������',i,'��']);
    imshow(uint8(pyramid{i}));
end

for i=1:3          %��òв�ͼ��
    expd{i}=expand(pyramid{i+1},w);
    residual{i}=pyramid{i}-expd{i};
end

  
figure('NumberTitle', 'off', 'Name', '�����ϲ������');
imshow(uint8(expd{1}));
figure('NumberTitle', 'off', 'Name', '����в�');
imshow(uint8(residual{1}));

for i=3:-1:1        %�в�ͼ���ع�ԭͼ��
    reconstruct{i}=expd{i}+residual{i};
end

figure('NumberTitle', 'off', 'Name', '�����ؽ����');
imshow(uint8(reconstruct{1}));
