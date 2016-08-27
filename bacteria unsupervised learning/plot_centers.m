function [ done ] = plot_centers( centroids,w,percent )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
done=0;
figure;
for i=1:size(centroids,2)
    subplot(10,10,rem(i-1,100)+1);
%     subplot(100,10,i); 
    imshow(reshape(centroids(:,i),w,w));
    if (rem(i,100) ==0) 
        figure;
        title(['resize', num2str(percent),'% patch w=',num2str(w)]);
    end
end
done =1;
end

