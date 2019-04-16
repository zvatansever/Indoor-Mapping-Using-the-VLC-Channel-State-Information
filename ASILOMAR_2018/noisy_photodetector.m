function [ ranges,angles,visible ] = noisy_photodetector( ranges,angles,visible,sRange,sAngle,sSignature )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

    ranges = ranges + sRange*randn(1,numel(ranges));
    angles = wrapToPi(angles + sAngle*randn(1,numel(angles)));
    if numel(visible) > 0
        visible = visible + sSignature*randn(1, numel(visible));
    end
end

