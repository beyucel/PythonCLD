clear all ,close all, clc
%%
BWa = imread('1Segmented.tiff');
figure
imshow(BWa)
%%

xca=LightningCLD(1-double(BWa),"x");
yca=LightningCLD(1-double(BWa),"y");
%%
load bw2circles.mat

figure
imagesc(bwdummy)


%xca=LightningCLD(bwdummy,"x");
%sum(xca)
A=double(BWa);
%%
B = imfilter(A,[0 -1 1],'circular');

figure,imagesc(B)
%%
[XR, YR, ZR] = ind2sub(size(permute(A,[2 1 3])),find(permute(B,[2 1 3])==-1));
[XL, YL, ZL] = ind2sub(size(permute(A,[2 1 3])),find(permute(B,[2 1 3])==1));

%%
[C, I, J] = unique(YR+(ZR-1)*size(A,2));
gridind = repelem(1:length(C),accumarray(J,ones(length(J),1)));
%% gridind= transpose of the j for the 2d cases.
dimlength=size(A,2);
sf=[]
for ii=1:max(gridind)
    xr=XR(find(gridind==ii));
    xl=XL(find(gridind==ii));
    if xr(1)<xl(1)
        s = circshift(xr,-1,1)-xl;
        s(end) = s(end) + dimlength;
    else
        s = xr-xl;
    end
    sf=[sf,s'];
end


% ll = splitapply(@(xr,xl) {getchords(xr,xl,size(A,2))},XR,XL,gridind');
 chords = histcounts(sf,0.5:(size(A,2)+0.5));





