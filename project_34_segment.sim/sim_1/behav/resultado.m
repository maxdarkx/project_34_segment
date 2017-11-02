clear all;close all;clc;
run('resultados3.m');run('resultados2.m');run('resultados1.m');
imagen(:,:,1)=uint8(r.*16);imagen(:,:,2)=uint8(g.*16);imagen(:,:,3)=uint8(b.*16);
imshow(imagen);impixelinfo();
