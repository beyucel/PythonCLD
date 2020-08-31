clear all ,close all, clc
%%
BWa = imread('1Segmented.tiff');
figure
imshow(BWa)
%%

xca=LightningCLD(1-double(BWa),"x");
yca=LightningCLD(1-double(BWa),"y");
%%
figure
bar(xca)