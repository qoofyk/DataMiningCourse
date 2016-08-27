clear all;
clc;
% extract patch from image then cluster,modify w and generated center
total10Dir = '..\12percent_total\';
list=dir([total10Dir,'*.png']);
w=12;
numpatch=150;
%generate fixed cordinate for each patch
i=1;
im=[total10Dir,list(i).name];
I=imread(im);
nr=size(I,1); nc=size(I,2);
% origin=zeros(100,2);
% for i=1:numpatch
%     origin(i,1)=randi(nc-w);
%     origin(i,2)=randi(nr-w);
% end

patch=zeros(numel(list)*numpatch,w*w);
for i=1:numel(list)
        im=[total10Dir,list(i).name];
        I=imread(im);
%         nr=size(I,1); nc=size(I,2);
        for kk=1:numpatch	        
%             tmpcrop=reshape(imcrop(I,[origin(kk,1) origin(kk,2) w-1 w-1]),1,w*w);
            tmpcrop=double(reshape(imcrop(I,[randi(nc-w) randi(nr-w) w-1 w-1]),1,w*w));
            patch((i-1)*numpatch+kk,:)=(tmpcrop-mean(tmpcrop))/(std(tmpcrop)+1e-100);
	    end
end

numClusters = 1000 ;
[P12_centers12, assignments] = vl_kmeans(patch', numClusters);
