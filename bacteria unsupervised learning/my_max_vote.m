function [ predict_label ] = my_max_vote( numgen,predict_label_org )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
vote=zeros(1227,numgen);
for i = 1:numgen
    vote(:,i) = predict_label_org((1+1227*(i-1)):(1227+1227*(i-1)),:);
end    
% vote=[predict_label(1:1227),predict_label(1228:2454),predict_label(2455:3681)];
maxvote=mode(vote,2);
predict_label=zeros(1227,1);
predict_label=maxvote;

end

