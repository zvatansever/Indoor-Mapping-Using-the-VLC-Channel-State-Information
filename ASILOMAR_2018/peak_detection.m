function [pksTrans,timeTrans] = peak_detection(imp_res,dFactor,pkThresh);
time=1:length(imp_res);
%% Downsample Data

selectedpeaks= downsample(imp_res,dFactor);

timeElapsed = downsample(time,dFactor);

%% Find Raw Peaks
[pks,timeAtpks] = findpeaks(selectedpeaks,timeElapsed);
%% Find Peak Diff, (corresponding) Hr Diff
pkDiff = abs(diff(pks));
pksTrans = pks(pkDiff>pkThresh);
timeTrans = timeAtpks(pkDiff>pkThresh);

end

