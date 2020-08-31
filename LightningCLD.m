function chords = LightningCLD(A,direction,varargin)
% Calculates the chord length frequency or distribution from 2D or 3D
% binary image.

if direction == 'x'

elseif direction == 'y'
    A = permute(A,[2 1 3]);
elseif direction == 'z'
    A = permute(A,[1 3 2]);
else
    error('Direction must either be ''x'', ''y'' or ''z''.')
end
    
% Detect Edges
B = imfilter(A,[0 -1 1],'circular');

% Identify Left and Right Chord Ends
[XR, YR, ZR] = ind2sub(size(permute(A,[2 1 3])),find(permute(B,[2 1 3])==-1));
[XL, YL, ZL] = ind2sub(size(permute(A,[2 1 3])),find(permute(B,[2 1 3])==1));

% X contains the needed information, Y and Z only contain grid information.
% Use Y and Z as a grid/group index for computation on X.
[C, I, J] = unique(YR+(ZR-1)*size(A,2));
gridind = repelem(1:length(C),accumarray(J,ones(length(J),1)));

% Get chords at each grid. Get distribution by histogram.
ll = splitapply(@(xr,xl) {getchords(xr,xl,size(A,2))},XR,XL,gridind');
chords = histcounts(cell2mat(ll),0.5:(size(A,2)+0.5));

% Normalize if requested.
if nargin == 3
    if varargin{1} == 'chordf'
        % By chord frequency.
        chords = chords./sum(chords);
    elseif varargin{1} == 'pixelf'
        % By pixel/voxel frequency.
        chords = (1:size(A,1)).*chords./sum((1:size(A,1)).*chords);
    else 
        error('Normalization must either be ''pixelf'' or ''chordf''')
    end     
end

function s = getchords(xr,xl,dimlength)
    if xr(1)<xl(1)
        s = circshift(xr,-1,1)-xl;
        s(end) = s(end) + dimlength;
    else
        s = xr-xl;
    end
end

end