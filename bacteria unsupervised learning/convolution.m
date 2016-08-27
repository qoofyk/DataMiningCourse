function [ feats ] = convolution( trainDir,Centers, name,degree, w )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tic;
% Centers=P10_centers10';
% trainDir = '..\10percent_total\smalldataset\';
list=dir([trainDir,name,num2str(degree,'%03d'),'*.png']);

% w=10;
feats=zeros(1833,1000);
% labs=zeros(1833,1);
%labs1=zeros(170000,1);
ncl=size(Centers,1);
% c=1;
parfor i=1:numel(list)
        i
        im=[trainDir,list(i).name];
        I=imread(im);
%         I=imresize(I,0.1);
        nr=size(I,1); nc=size(I,2);
        oneimage = zeros(1,1000);
        for ii=w/2:nr-w/2
            for jj=w/2:nc-w/2
                    tmp=double(reshape(I(ii-w/2+1:ii+w/2,jj-w/2+1:jj+w/2,:),w*w,1));
                    tmp=(tmp-mean(tmp))/(std(tmp)+1e-100); %whitening
                    tmp=Centers-ones(ncl,1)*tmp';
                    dist=sqrt(sum(tmp.*tmp,2));
                    softvals=max(0,mean(dist)-dist);%negative set to 0;
%                     feats(c,:)=feats(c,:)+softvals';
                    oneimage=oneimage+softvals';
            end
        end
       
        feats(i,:) = oneimage;   
        
end

end

