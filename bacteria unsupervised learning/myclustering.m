function [ Centroids ] = myclustering( totalDir, w, numpatch,numClusters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
list=dir([totalDir,'*.png']);
%generate fixed cordinate for each patch
im=[totalDir,list(1).name];
I=imread(im);
nr=size(I,1); nc=size(I,2);
% origin=zeros(100,2);
% for i=1:numpatch
%     origin(i,1)=randi(nc-w);
%     origin(i,2)=randi(nr-w);
% end

patch=zeros(w*w,numel(list)*numpatch);
each_image_patch=zeros(w*w,numpatch);
for i=1:numel(list)
        im=[totalDir,list(i).name];
        I=imread(im);
        parfor kk=1:numpatch	        
%             tmpcrop=reshape(imcrop(I,[origin(kk,1) origin(kk,2) w-1 w-1]),1,w*w);
            tmpcrop=double(reshape(imcrop(I,[randi(nc-w) randi(nr-w) w-1 w-1]),w*w,1));
            each_image_patch(:,kk)=(tmpcrop-mean(tmpcrop))/(std(tmpcrop)+1e-100);
        end
        patch(:,((i-1)*numpatch+1):(i*numpatch))=each_image_patch;
end

[Centroids, assignments] = vl_kmeans(patch, numClusters);

end


