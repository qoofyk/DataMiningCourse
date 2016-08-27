clc;
clear all;

% resize 10% center w=6 
Centers=P10_centers6';
trainDir = '..\10percent_total\';
P10_rot270_feats6=convolution(trainDir,Centers,'ROT',270,6);
P10_rot315_feats6=convolution(Centers,315,6);

Centers=P8_centers8';
trainDir = '..\08percent_total\';
P8_rte135_feats8=convolution(trainDir,Centers,'RTE',135,8);
P8_rot180_feats8=convolution(trainDir,Centers,'RTE',180,8);
P8_rot225_feats8=convolution(trainDir,Centers,'RTE',225,8);
P8_rot270_feats8=convolution(trainDir,Centers,'RTE',270,8);
P8_rot315_feats8=convolution(trainDir,Centers,'RTE',315,8);
P8_hoz_feats8=convolution(trainDir,Centers,'HOZ',008,8);
P8_ver_feats8=convolution(trainDir,Centers,'VER',008,8);
P8_hzv_feats8=convolution(trainDir,Centers,'HZV',008,8);