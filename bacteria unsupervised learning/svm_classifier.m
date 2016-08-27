clear all;
%20150507
feat_org=stdNormalize([P8_feat6_org,P8_feat8_org,P8_feat10_org,P10_feat6_org,P10_feat8_org,P10_feat10_org]);
feat_180=stdNormalize([P8_rot180_feat6,P8_rot180_feat8,P8_rot180_feat10,P10_rot180_feat6,P10_rot180_feat8,P10_rot180_feat10]);
feat_rot_165=stdNormalize([P8_feat6_165,P8_feat8_165,P8_feat10_165,P10_feat6_165,P10_feat8_165,P10_feat10_165]);
feat_rot_345=stdNormalize([P8_feat6_345,P8_feat8_345,P8_feat10_345,P10_feat6_345,P10_feat8_345,P10_feat10_345]);
feat_hoz=stdNormalize([P8_hov_feat6,P8_hov_feat8,P8_hov_feat10,P10_hov_feat6,P10_hov_feat8,P10_hov_feat10]);
feat_ver=stdNormalize([P8_ver_feat6,P8_ver_feat8,P8_ver_feat10,P10_ver_feat6,P10_ver_feat8,P10_ver_feat10]);
feat_hzv=stdNormalize([P8_hzv_feat6,P8_hzv_feat8,P8_hzv_feat10,P10_hzv_feat6,P10_hzv_feat8,P10_hzv_feat10]);

%resize 8% patch 6,8,10
FINALX=stdNormalize([P8_feat6_org;P8_feat6_165;P8_feat6_345;P8_rot180_feat6;P8_hov_feat6;P8_ver_feat6;P8_hzv_feat6]);
FINALX=stdNormalize([P8_feat8_org;P8_feat8_165;P8_feat8_345;P8_rot180_feat8;P8_hov_feat8;P8_ver_feat8;P8_hzv_feat8]);
FINALX=stdNormalize([P8_feat10_org;P8_feat10_165;P8_feat10_345;P8_rot180_feat10;P8_hov_feat10;P8_ver_feat10;P8_hzv_feat10]);
%resize 10% patch 6,8,10
FINALX=stdNormalize([P10_feat6_org;P10_feat6_165;P10_feat6_345;P10_rot180_feat6;P10_hov_feat6;P10_ver_feat6;P10_hzv_feat6]);
FINALX=stdNormalize([P10_feat8_org;P10_feat8_165;P10_feat8_345;P10_rot180_feat8;P10_hov_feat8;P10_ver_feat8;P10_hzv_feat8]);
FINALX=stdNormalize([P10_feat10_org;P10_feat10_165;P10_feat10_345;P10_rot180_feat10;P10_hov_feat10;P10_ver_feat10;P10_hzv_feat10]);

% two patch 8 10
feat_org=stdNormalize([P8_feat8_org,P8_feat10_org,P10_feat8_org,P10_feat10_org]);
feat_180=stdNormalize([P8_rot180_feat8,P8_rot180_feat10,P10_rot180_feat8,P10_rot180_feat10]);
feat_rot_165=stdNormalize([P8_feat8_165,P8_feat10_165,P10_feat8_165,P10_feat10_165]);
feat_rot_345=stdNormalize([P8_feat8_345,P8_feat10_345,P10_feat8_345,P10_feat10_345]);
feat_hoz=stdNormalize([P8_hov_feat8,P8_hov_feat10,P10_hov_feat8,P10_hov_feat10]);
feat_ver=stdNormalize([P8_ver_feat8,P8_ver_feat10,P10_ver_feat8,P10_ver_feat10]);
feat_hzv=stdNormalize([P8_hzv_feat8,P8_hzv_feat10,P10_hzv_feat8,P10_hzv_feat10]);

% one patch 10
feat_org=stdNormalize([P8_feat10_org,P10_feat10_org]);
feat_180=stdNormalize([P8_rot180_feat10,P10_rot180_feat10]);
feat_rot_165=stdNormalize([P8_feat10_165,P10_feat10_165]);
feat_rot_345=stdNormalize([P8_feat10_345,P10_feat10_345]);
feat_hoz=stdNormalize([P8_hov_feat10,P10_hov_feat10]);
feat_ver=stdNormalize([P8_ver_feat10,P10_ver_feat10]);
feat_hzv=stdNormalize([P8_hzv_feat10,P10_hzv_feat10]);

FINALX=[feat_org;feat_rot_165;feat_rot_345;feat_180;feat_hzv;feat_ver;feat_hzv];

numgen=27;
[FINALTRAINLABEL,train_index,test_index] = get_proper_label(numgen);

% train_index=[finalTrainnum;(finalTrainnum+ones(606,1)*1833);(finalTrainnum+ones(606,1)*1833*2);];
% test_index=[finalTestnum;(finalTestnum+ones(1227,1)*1833);(finalTestnum+ones(1227,1)*1833*2);];
FINALX=[feat_org;feat_rot045;feat_rot090;feat_rot135;feat_rot180;feat_rot225;feat_rot270;feat_rot315;feat_hoz;feat_ver;feat_hzv];

%'-s 5 -c 0.025 -v 5'
% newmodel5 =  train(FINALTRAINLABEL,sparse(FINALX(train_index,:)),'-s 5 -c 1 -v 5')
% newmodel5 =  train(FINALTRAINLABEL,sparse(FINALX(train_index,:)),'-s 5 -c 1')

Train_Feature_Matrix=sparse(FINALX(train_index,:));
Test_Feature_Matrix=sparse(FINALX(test_index,:));
clear FINALX;
newmodel5 =  train(FINALTRAINLABEL,Train_Feature_Matrix,'-s 5 -c 1 -v 5')
newmodel5 =  train(FINALTRAINLABEL,Train_Feature_Matrix,'-s 5 -c 2')
testing_label_vector=ones(1227*numgen,1);
[predict_label_org, accuracy, dec_values] = predict(testing_label_vector, Test_Feature_Matrix, newmodel5);

% testing_label_vector=ones(1227,1);
% [predict_label, accuracy, dec_values] = predict(testing_label_vector, sparse(FINALX(finalTestnum,:)), newmodel5);
% max vote
predict_label=my_max_vote(numgen,predict_label_org);

% without maxvote
predict_label=predict_label_org(1:1227,1);
%small test
smalltest=stdNormalize(P10_feats12);
[predict_label, accuracy, dec_values] = predict(newYtrain, sparse(smalltest(finalTrainnum,:)), newmodel5);

% single
newmodel5 =  train(newYtrain,sparse(feat(finalTrainnum,:)),'-s 5 -c 30 -v 5')
newmodel5 =  train(newYtrain,sparse(feat(finalTrainnum,:)),'-s 5 -c 30')
% newmodel5 =  train(newYtrain,sparse(X1(finalTrainnum,:)),'-s 5 -c 200')
smalltest=stdNormalize(P10_rot045_feats10);
[predict_label, accuracy, dec_values] = predict(newYtrain, sparse(smalltest(finalTrainnum,:)), newmodel5);
testing_label_vector=ones(1227,1);
[predict_label, accuracy, dec_values] = predict(testing_label_vector, sparse(feat(finalTestnum,:)), newmodel5);

%pca
[coeff,score,latent] = pca(feat);
myscore = score(:,1:400);
pcatrainx=sparse(myscore(finalTrainnum,:));
newmodel5 =  train(newYtrain,pcatrainx,'-s 5 -c 1 -v 5')
newmodel5 =  train(newYtrain,pcatrainx,'-s 5 -c 2')
% non5=sum(newmodel5.w~=0,2)
testing_label_vector=ones(1227,1);
[predict_label, accuracy, dec_values] = predict(testing_label_vector, sparse(myscore(finalTestnum,:)), newmodel5);
[predict_label, accuracy, dec_values] = predict(newYtrain, sparse(FINALX(finalTrainnum+ones(606,1)*1833*2,:)), newmodel5);

%svd
X=feat;
[U,S,V]=svd(X);
Seig = eig(S(1:1072,:));
URed=U(:,1:15);
%URed = sparse(URed);
aml_inst = sparse(URed);
aml_label = newYtrain;
model0 = train(aml_label,aml_inst,'-s 0 -v 5 -c 0.6')
model1 = train(aml_label,aml_inst,'-s 1 -v 5 -c 0.001')
model2 = train(aml_label,aml_inst,'-s 2 -v 5 -c 0.08')
model3 = train(aml_label,aml_inst,'-s 3 -v 5 -c 0.5')
model4 = train(aml_label,aml_inst,'-s 4 -v 5 -c 0.1')
model5 = train(aml_label,aml_inst,'-s 5 -v 5 -c 5')
model6 = train(aml_label,aml_inst,'-s 6 -v 5 -c 3')
model7 = train(aml_label,aml_inst,'-s 7 -v 5 -c 0.05')

% ZCA normalization
    CC=cov(feat);
    [VV DD]=eig(CC);
    X=feats*VV*DD^(-1/2);

% get text label
finalpredictLabel=cell(1227,1);

for i=1:1227
    if predict_label(i)==1
        finalpredictLabel(i)=cellstr('ecoli');
    elseif predict_label(i)==2
        finalpredictLabel(i)=cellstr('salmonella');
    elseif predict_label(i)==3
        finalpredictLabel(i)=cellstr('staphylococus');
    elseif predict_label(i)==4
        finalpredictLabel(i)=cellstr('listeria');
    else
        finalpredictLabel(i)=cellstr('none');
    end
end


UP = 5; % modify the upper bound for C
interval = 0.015;

% tune c for each solver
newmodel3 =  train(newYtrain,sparse(X(finalTrainnum,:)),'-s 3 -c 100 -v 5')
Y=newYtrain;
tX=sparse(X(finalTrainnum,:));

model0=[];
model1=[];
model2=[];
model3=[];
model5=[];
model6=[];
model7=[];

[model0,c0,acc0]=tuneC(model0,interval,UP,Y,tX,0);
[model1,c1,acc1]=tuneC(model1,interval,UP,Y,tX,1);
[model2,c2,acc2]=tuneC(model2,interval,UP,Y,tX,2);
[model3,c3,acc3]=tuneC(model3,interval,UP,Y,tX,3);

[model5,c5,acc5]=tuneC(model5,interval,UP,Y,tX,5);
[model6,c6,acc6]=tuneC(model6,interval,UP,Y,tX,6);
[model7,c7,acc7]=tuneC(model7,interval,UP,Y,tX,7);

%calculate the training time
str0=['-s 0 -c ' num2str(c0) ' -v 5'];
str1=['-s 1 -c ' num2str(c1) ' -v 5'];
str2=['-s 2 -c ' num2str(c2) ' -v 5'];
str3=['-s 3 -c ' num2str(c3) ' -v 5'];
str5=['-s 5 -c ' num2str(c5) ' -v 5'];
str6=['-s 6 -c ' num2str(c6) ' -v 5'];
str7=['-s 7 -c ' num2str(c7) ' -v 5'];

tic;model0_op =  train(Y,sparse(tX),str0);toc;elsp0=toc;
tic;model1_op =  train(Y,sparse(tX),str1);toc;elsp1=toc;
tic;model2_op =  train(Y,sparse(tX),str2);toc;elsp2=toc;
tic;model3_op =  train(Y,sparse(tX),str3);toc;elsp3=toc;

tic;model5_op =  train(Y,sparse(tX),str5);toc;elsp5=toc;
tic;model6_op =  train(Y,sparse(tX),str6);toc;elsp6=toc;
tic;model7_op =  train(Y,sparse(tX),str7);toc;elsp7=toc;

testing_label_vector=ones(1227,1);
[predict_label, accuracy, dec_values] = predict(testing_label_vector, sparse(X(finalTestnum,:)), model7_op);

% increas or decrease c to find the number of nonzero coeffients in w
% mannual operation for increase or decrease c parameter.
newmodel0 =  train(Y,sparse(X),'-s 0 -c 100')
non0=sum(newmodel0.w~=0,2);

newmodel1 =  train(Y,sparse(X),'-s 1 -c 10')
non1=sum(newmodel1.w~=0,2);

newmodel2 =  train(Y,sparse(X),'-s 2 -c 10')
non2=sum(newmodel2.w~=0,2);

newmodel3 =  train(Y,sparse(X),'-s 3 -c 10')
non0=sum(newmodel0.w~=0,2);

newmodel5 =  train(Y,sparse(X),'-s 5 -c 1')
non5=sum(newmodel5.w~=0,2);

newmodel6 =  train(Y,sparse(X),'-s 6 -c 0.1')
non6=sum(newmodel6.w~=0,2);

newmodel7 =  train(Y,sparse(X),'-s 7 -c 10')
non7=sum(newmodel7.w~=0,2);
