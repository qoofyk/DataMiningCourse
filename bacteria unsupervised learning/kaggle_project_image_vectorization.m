clear all;
clc;
%modify centers, list, w, feats
% trainDir = '..\NewTotal\';
% % trainDir='directory'; % directory for the raw images (put test and train images in the same directory)
% fname='Centers.dat'; % matlab file for the centroids

% load(fname);
% list=dir([trainDir,'*.png']);
% [ncl,d]=size(Centers);

%20140409
Centers=P10_centers6';
trainDir = '..\10percent_total\';
list=dir([trainDir,'ROT225*.png']);

w=6;
feats=zeros(1833,1000);
% labs=zeros(1833,1);
%labs1=zeros(170000,1);
ncl=size(Centers,1);
% c=1;
parfor i=1:numel(list)
        im=[trainDir,list(i).name];
        I=imread(im);
%         I=imresize(I,0.1);
        nr=size(I,1); nc=size(I,2);
        oneimage=zeros(1,1000);
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
       feats(i,:)=oneimage;
%        c=c+1
  
        
end
    
P10_rot225_feats6=feats;

% get my feature matrix
% feat_org=stdNormalize([P10_feats6,P10_feats8,P10_feats10,P8_feats6,P8_feats8,P8_feats10]);
% feat_org=stdNormalize([P10_feats6,P10_feats8,P10_feats10,P10_feats12,P8_feats6,P8_feats8,P8_feats10,P8_feats12]);
% feat_rot045=stdNormalize([P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10,P10_rot045_feats12,P8_rte045_feats6,P8_rte045_feats8,P8_rte045_feats10,P8_rte045_feats12]);
% feat_rot090=stdNormalize([P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10,P10_rot090_feats12,P8_rte090_feats6,P8_rte090_feats8,P8_rte090_feats10,P8_rte090_feats12]);
% feat=stdNormalize([P10_feats6,P10_feats8,P10_feats10,P10_feats12,P8_feats6,P8_feats8,P8_feats10,P8_feats12,P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10,P10_rot045_feats12,P8_rte045_feats6,P8_rte045_feats8,P8_rte045_feats10,P8_rte045_feats12,P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10,P10_rot090_feats12,P8_rte090_feats6,P8_rte090_feats8,P8_rte090_feats10,P8_rte090_feats12,P15_res015_feats6,P15_res015_feats8,P15_res015_feats10]);
% feat=[P10_feats6,P10_feats8,P10_feats10,P10_feats12,P8_feats6,P8_feats8,P8_feats10,P8_feats12,P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10,P10_rot045_feats12,P8_rte045_feats6,P8_rte045_feats8,P8_rte045_feats10,P8_rte045_feats12,P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10,P10_rot090_feats12,P8_rte090_feats6,P8_rte090_feats8,P8_rte090_feats10,P8_rte090_feats12,P15_res015_feats6,P15_res015_feats8,P15_res015_feats10];

% feat_org=[stdNormalize([P10_feats6,P10_feats8,P10_feats10,P10_feats12]);stdNormalize([P8_feats6,P8_feats8,P8_feats10,P8_feats12]);stdNormalize([P15_res015_feats6,P15_res015_feats8,P15_res015_feats10,P15_res015_feats12])];
% feat_rot045=[stdNormalize([P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10,P10_rot045_feats12]);stdNormalize([P8_rte045_feats6,P8_rte045_feats8,P8_rte045_feats10,P8_rte045_feats12]);];
% feat_rot090=[stdNormalize([P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10,P10_rot090_feats12]);stdNormalize([P8_rte090_feats6,P8_rte090_feats8,P8_rte090_feats10,P8_rte090_feats12]);];

%vertical concatenate
feat_org=[stdNormalize([P10_feats6,P10_feats8,P10_feats10]);stdNormalize([P8_feats6,P8_feats8,P8_feats10]);stdNormalize([P15_res015_feats6,P15_res015_feats8,P15_res015_feats10])];
feat_rot045=[stdNormalize([P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10]);stdNormalize([P8_rot045_feats6,P8_rot045_feats8,P8_rot045_feats10]);stdNormalize([P15_rot045_feats6,P15_rot045_feats8,P15_rot045_feats10])];
feat_rot090=[stdNormalize([P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10]);stdNormalize([P8_rot090_feats6,P8_rot090_feats8,P8_rot090_feats10]);stdNormalize([P15_rot090_feats6,P15_rot090_feats8,P15_rot090_feats10])];
feat_rot135=[stdNormalize([P10_rot135_feats6,P10_rot135_feats8,P10_rot135_feats10]);stdNormalize([P8_rot135_feats6,P8_rot135_feats8,P8_rot135_feats10]);stdNormalize([P15_rot135_feats6,P15_rot135_feats8,P15_rot135_feats10])];
feat_rot180=[stdNormalize([P10_rot180_feats6,P10_rot180_feats8,P10_rot180_feats10]);stdNormalize([P8_rot180_feats6,P8_rot180_feats8,P8_rot180_feats10]);stdNormalize([P15_rot180_feats6,P15_rot180_feats8,P15_rot180_feats10])];
feat_rot225=[stdNormalize([P10_rot225_feats6,P10_rot225_feats8,P10_rot225_feats10]);stdNormalize([P8_rot225_feats6,P8_rot225_feats8,P8_rot225_feats10]);stdNormalize([P15_rot225_feats6,P15_rot225_feats8,P15_rot225_feats10])];
feat_rot270=[stdNormalize([P10_rot270_feats6,P10_rot270_feats8,P10_rot270_feats10]);stdNormalize([P8_rot270_feats6,P8_rot270_feats8,P8_rot270_feats10]);stdNormalize([P15_rot270_feats6,P15_rot270_feats8,P15_rot270_feats10])];
feat_rot315=[stdNormalize([P10_rot315_feats6,P10_rot315_feats8,P10_rot315_feats10]);stdNormalize([P8_rot315_feats6,P8_rot315_feats8,P8_rot315_feats10]);stdNormalize([P15_rot315_feats6,P15_rot315_feats8,P15_rot315_feats10])];
feat_hoz=[stdNormalize([P10_hoz_feats6,P10_hoz_feats8,P10_hoz_feats10]);stdNormalize([P8_hoz_feats6,P8_hoz_feats8,P8_hoz_feats10]);stdNormalize([P15_hoz_feats6,P15_hoz_feats8,P15_hoz_feats10]);];
feat_ver=[stdNormalize([P10_ver_feats6,P10_ver_feats8,P10_ver_feats10]);stdNormalize([P8_ver_feats6,P8_ver_feats8,P8_ver_feats10]);stdNormalize([P15_ver_feats6,P15_ver_feats8,P15_ver_feats10]);];
feat_hzv=[stdNormalize([P10_hzv_feats6,P10_hzv_feats8,P10_hzv_feats10]);stdNormalize([P8_hzv_feats6,P8_hzv_feats8,P8_hzv_feats10]);stdNormalize([P15_hzv_feats6,P15_hzv_feats8,P15_hzv_feats10]);];

% horisitanal concatenate
feat_org=stdNormalize([P10_feats6,P10_feats8,P10_feats10,P8_feats6,P8_feats8,P8_feats10,P15_res015_feats6,P15_res015_feats8,P15_res015_feats10]);
feat_rot045=stdNormalize([P10_rot045_feats6,P10_rot045_feats8,P10_rot045_feats10,P8_rot045_feats6,P8_rot045_feats8,P8_rot045_feats10,P15_rot045_feats6,P15_rot045_feats8,P15_rot045_feats10]);
feat_rot090=stdNormalize([P10_rot090_feats6,P10_rot090_feats8,P10_rot090_feats10,P8_rot090_feats6,P8_rot090_feats8,P8_rot090_feats10,P15_rot090_feats6,P15_rot090_feats8,P15_rot090_feats10]);
feat_rot135=stdNormalize([P10_rot135_feats6,P10_rot135_feats8,P10_rot135_feats10,P8_rot135_feats6,P8_rot135_feats8,P8_rot135_feats10,P15_rot135_feats6,P15_rot135_feats8,P15_rot135_feats10]);
feat_rot180=stdNormalize([P10_rot180_feats6,P10_rot180_feats8,P10_rot180_feats10,P8_rot180_feats6,P8_rot180_feats8,P8_rot180_feats10,P15_rot180_feats6,P15_rot180_feats8,P15_rot180_feats10]);
feat_rot225=stdNormalize([P10_rot225_feats6,P10_rot225_feats8,P10_rot225_feats10,P8_rot225_feats6,P8_rot225_feats8,P8_rot225_feats10,P15_rot225_feats6,P15_rot225_feats8,P15_rot225_feats10]);
feat_rot270=stdNormalize([P10_rot270_feats6,P10_rot270_feats8,P10_rot270_feats10,P8_rot270_feats6,P8_rot270_feats8,P8_rot270_feats10,P15_rot270_feats6,P15_rot270_feats8,P15_rot270_feats10]);
feat_rot315=stdNormalize([P10_rot315_feats6,P10_rot315_feats8,P10_rot315_feats10,P8_rot315_feats6,P8_rot315_feats8,P8_rot315_feats10,P15_rot315_feats6,P15_rot315_feats8,P15_rot315_feats10]);
feat_hoz=stdNormalize([P10_hoz_feats6,P10_hoz_feats8,P10_hoz_feats10,P8_hoz_feats6,P8_hoz_feats8,P8_hoz_feats10,P15_hoz_feats6,P15_hoz_feats8,P15_hoz_feats10]);
feat_ver=stdNormalize([P10_ver_feats6,P10_ver_feats8,P10_ver_feats10,P8_ver_feats6,P8_ver_feats8,P8_ver_feats10,P15_ver_feats6,P15_ver_feats8,P15_ver_feats10]);
feat_hzv=stdNormalize([P10_hzv_feats6,P10_hzv_feats8,P10_hzv_feats10,P8_hzv_feats6,P8_hzv_feats8,P8_hzv_feats10,P15_hzv_feats6,P15_hzv_feats8,P15_hzv_feats10]);

%20150507
feat_org=stdNormalize([P8_feat6_org,P8_feat8_org,P8_feat10_org,P10_feat6_org,P10_feat8_org,P10_feat10_org]);
feat_180=stdNormalize([P8_rot180_feat6,P8_rot180_feat8,P8_rot180_feat10,P10_rot180_feat6,P10_rot180_feat8,P10_rot180_feat10]);
feat_rot_165=stdNormalize([P8_feat6_165,P8_feat8_165,P8_feat10_165,P10_feat6_165,P10_feat8_165,P10_feat10_165]);
feat_rot_345=stdNormalize([P8_feat6_345,P8_feat8_345,P8_feat10_345,P10_feat6_345,P10_feat8_345,P10_feat10_345]);
feat_hoz=stdNormalize([P10_hov_feat6,P10_hov_feat8,P10_hov_feat10,P8_hov_feat6,P8_hov_feat8,P8_hov_feat10]);
feat_ver=stdNormalize([P8_ver_feat6,P8_ver_feat8,P8_ver_feat10,P10_ver_feat6,P10_ver_feat8,P10_ver_feat10]);
feat_hzv=stdNormalize([P8_hzv_feat6,P8_hzv_feat8,P8_hzv_feat10,P10_hzv_feat6,P10_hzv_feat8,P10_hzv_feat10]);

%show centers
w=10;
percent=8;
centroids=P8_centers10;
done = plot_centers( centroids,w,percent );

figure;
for i=1:1000
    subplot(100,10,i);
    imshow(reshape(centroids(:,i),w,w));
end
