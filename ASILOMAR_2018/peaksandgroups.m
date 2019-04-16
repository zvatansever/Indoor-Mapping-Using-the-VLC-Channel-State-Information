function [peaks,groups,criterion] = peaksandgroups(V,select,display)
% -------------------------------------------------------------
% Find peaks and link each data point to a peak
% ---------------------------------------------
% This function looks for peaks in the data using the LAZYCLIMB method.
% This won't help you much, since lazyclimb is a name I just made up for
% this algorithm.
% 
% input : 
%   * V : data, a vector of length N
%   * select : either: 
%       - select >1 : the number of peaks to detect
%       - 0<select<1 : the threshold to apply for finding peaks 
%         the closer to 1, the less peaks, the closer to 0, the more peaks
%   * display : whether or not to display a figure for the results. 0 by
%               default
%   * ... and that's all ! that's the cool thing about the algorithm =)
% 
% outputs :
%   * peaks : indices of the peaks.
%   * groups: the number of the peak each point is assigned to. Nx1 vector
%   * criterion : the value of the computed criterion. Nx1 vector. A high 
%                 value indicates a point which is likely to be a peak
% 
% The algorithm goes as follows:
% 1°) Sort data in decreasing order, keep corresponding positions as order
% 2°) for all pos=1:n, 
%   * set order(pos) as the current point (from bigger to smaller)
%   * look for the closest already processed points, at left and right
%   * for each of them, compute a cost and select the one with lower cost
%     as the father of current. The cost corresponds to the area of the
%     difference between straight line and actual observed curve. The
%     rationale is that if you've got a peak, it would be tiring to go from
%     it to the place you were before, and this is measured as the
%     difference with a straight line. 
% 3°) This gives you a criterion for all point, as well as the father of
%     each point
% 4°) Threshold the criterion so that you either got a given number of
%     peaks, or so that you got few or many peaks
% 5°) Propagate the information to all points so that each point is given a
%     group number
% 
% I don't know if that kind of algorithm has already been published
% somewhere, I coded it myself and it works pretty nice, so.. enjoy !
% If you find it useful, please mention it in your studies =)
% 
% running time IS PRETTY SLOW, due to the identification of the closest
% already processed points on left and right, and to the computation of the
% criterion. If you got some nice ways to have it go faster, please tell
% me.
% ---------------------------------------------------------------------
% (c) Antoine Liutkus, 2013
% ---------------------------------------------------------------------

%data is a vector
V = V(:)-min((V(:)));

%input parsin
if nargin < 3
    display=0;
end
if nargin < 2
    select= 0.8;
end

V = V(:);
n = length(V);

%definition of local variables
criterion = zeros(n,1);
fathers = zeros(n,1);

%sorting the data
[Vsort,order] = sort(V,'descend');

%Setting the root of the tree
fathers(order(1))=order(1);

%Now looping over all data, from higher to smaller
str = [];
for pos = 2:n
    %display
    if rem(pos,round(n/20))==1
        fprintf(repmat('\b',1,length(str)));
        str=sprintf('       Building connection tree : %0.1f%%', pos/n*100);
        fprintf('%s', str);
    end
    %set current point
    current = order(pos);
    
    %Getting left and right closest processed points. There may be ways to
    %improve this, it's rather dull as it is. For each one of them, compute
    %the criterion
    left  = find(order(1:(pos-1))<current);
    right = find(order(1:(pos-1))>current);
    if ~isempty(left)
        [~,closest_left] = min(abs(current-order(left)));
        closest_left = order(left(closest_left));
        line = linspace(V(closest_left),V(current),current-closest_left+1)';
        crit_left = sum(abs(line-V(closest_left:current)));
    else
        crit_left = inf;
    end
    if ~isempty(right)
        [~,closest_right] = min(abs(current-order(right)));
        closest_right = order(right(closest_right));
        line = linspace(V(current),V(current),closest_right-current+1)';
        crit_right = sum(abs(line-V(current:closest_right)));
    else
        crit_right=inf;
    end
    %Now sets the father as the one giving the smallest criterion
    if crit_left<crit_right
        fathers(current) = closest_left;
        criterion(current) = crit_left;
    else
        fathers(current) = closest_right;
        criterion(current) = crit_right;
    end
end
fprintf(repmat('\b',1,length(str)));
fprintf('       Building connection tree : Done.\n');

%normalize criterion
M = max(criterion);
criterion(order(1)) = M+1; %do not forget to give the root the highest value
criterion = criterion/max(criterion);

%find peaks based on criterion
if select<1
    [HH,VV] = hist(log(criterion(criterion>min(criterion(:)))),1000);
    HH = cumsum(HH);
    HH = HH/HH(end);
    p = 0.9+select*0.1;
    first = find(HH>p,1,'first');
    peaks = find(log(criterion)>VV(first));
else
    [~,order] = sort(criterion,'descend');
    peaks = order(1:select);
end

%Now propagate the group information from peaks to all points. Do a simple
%dynamic programming stuf for this
groups = zeros(n,1);
groups(peaks) = 1:length(peaks);
changed = 1;
while changed
    changed=0;
    for pos = 1:n
        if ~groups(pos)
            groups(pos)= groups(fathers(pos));
            changed=1;
        end
    end
end

%display if needed
if display
    clf
    for igroup=1:length(peaks)
        hold on
        I = find(groups==igroup);
        plot(I,V(I),'Color',rand(3,1),'LineWidth',2)
        hold on
        plot(peaks(igroup),V(peaks(igroup)),'ro','MarkerSize',10,'LineWidth',2)
    end
    grid on
    title('Peaks and groups detection','FontSize',16);
end

