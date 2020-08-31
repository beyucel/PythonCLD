function s = getchords(xr,xl,dimlength)
    if xr(1)<xl(1)
        s = circshift(xr,-1,1)-xl;
        s(end) = s(end) + dimlength;
    else
        s = xr-xl;
    end
end