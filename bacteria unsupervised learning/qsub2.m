clc;
clear all;

%resize 10% center w=6
Centers=P10_centers6';
P10_rot270_feats6=convolution(Centers,'ROT',270,6);
P10_rot315_feats6=convolution(Centers,'ROT',315,6);
P10_hoz_feats6=convolution(Centers,'HOZ',000,6);
P10_ver_feats6=convolution(Centers,'VER',000,6);
P10_hzv_feats6=convolution(Centers,'HZV',000,6);

Centers=P10_centers8';
P10_rot225_feats8=convolution(Centers,'ROT',225,8);
P10_rot270_feats8=convolution(Centers,'ROT',270,8);
P10_rot315_feats8=convolution(Centers,'ROT',315,8);
P10_hoz_feats8=convolution(Centers,'HOZ',000,8);
P10_ver_feats8=convolution(Centers,'VER',000,8);
P10_hzv_feats8=convolution(Centers,'HZV',000,8);

Centers=P10_centers10';
P10_rot225_feats10=convolution(Centers,'ROT',225,10);
P10_rot270_feats10=convolution(Centers,'ROT',270,10);
P10_rot315_feats10=convolution(Centers,'ROT',315,10);
P10_hoz_feats10=convolution(Centers,'HOZ',000,10);
P10_ver_feats10=convolution(Centers,'VER',000,10);
P10_hzv_feats10=convolution(Centers,'HZV',000,10);

Centers=P8_centers6';
trainDir = '..\08percent_total\';
P8_rte135_feats6=convolution(trainDir,Centers,'RTE',135,6);
P8_rot180_feats6=convolution(trainDir,Centers,'RTE',180,6);
P8_rot225_feats6=convolution(trainDir,Centers,'RTE',225,6);
P8_rot270_feats6=convolution(trainDir,Centers,'RTE',270,6);
P8_rot315_feats6=convolution(trainDir,Centers,'RTE',315,6);
P8_hoz_feats6=convolution(trainDir,Centers,'HOZ',008,6);
P8_ver_feats6=convolution(trainDir,Centers,'VER',008,6);
P8_hzv_feats6=convolution(trainDir,Centers,'HZV',008,6);

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



Centers=P8_centers10';
trainDir = '..\08percent_total\';
P8_rte135_feats10=convolution(trainDir,Centers,'RTE',135,10);
P8_rot180_feats10=convolution(trainDir,Centers,'RTE',180,10);
P8_rot225_feats10=convolution(trainDir,Centers,'RTE',225,10);
P8_rot270_feats10=convolution(trainDir,Centers,'RTE',270,10);
P8_rot315_feats10=convolution(trainDir,Centers,'RTE',315,10);
P8_hoz_feats10=convolution(trainDir,Centers,'HOZ',008,10);
P8_ver_feats10=convolution(trainDir,Centers,'VER',008,10);
P8_hzv_feats10=convolution(trainDir,Centers,'HZV',008,10);



Centers=P15_centers6';
trainDir = '..\15percent_total\';
P15_rot135_feats6=convolution(trainDir,Centers,'RTF',135,6);
P15_rot180_feats6=convolution(trainDir,Centers,'RTF',180,6);
P15_rot225_feats6=convolution(trainDir,Centers,'RTF',225,6);
P15_rot270_feats6=convolution(trainDir,Centers,'RTF',270,6);
P15_rot315_feats6=convolution(trainDir,Centers,'RTF',315,6);
P15_hoz_feats6=convolution(trainDir,Centers,'HOZ',015,6);
P15_ver_feats6=convolution(trainDir,Centers,'VER',015,6);
P15_hzv_feats6=convolution(trainDir,Centers,'HZV',015,6);

Centers=P8_centers8';
trainDir = '..\15percent_total\';
P15_rot135_feats8=convolution(trainDir,Centers,'RTF',135,8);
P15_rot180_feats8=convolution(trainDir,Centers,'RTF',180,8);
P15_rot225_feats8=convolution(trainDir,Centers,'RTF',225,8);
P15_rot270_feats8=convolution(trainDir,Centers,'RTF',270,8);
P15_rot315_feats8=convolution(trainDir,Centers,'RTF',315,8);
P15_hoz_feats8=convolution(trainDir,Centers,'HOZ',015,8);
P15_ver_feats8=convolution(trainDir,Centers,'VER',015,8);
P15_hzv_feats8=convolution(trainDir,Centers,'HZV',015,8);



Centers=P8_centers10';
trainDir = '..\15percent_total\';
P15_rot135_feats10=convolution(trainDir,Centers,'RTF',135,10);
P15_rot180_feats10=convolution(trainDir,Centers,'RTF',180,10);
P15_rot225_feats10=convolution(trainDir,Centers,'RTF',225,10);
P15_rot270_feats10=convolution(trainDir,Centers,'RTF',270,10);
P15_rot315_feats10=convolution(trainDir,Centers,'RTF',315,10);
P15_hoz_feats10=convolution(trainDir,Centers,'HOZ',015,10);
P15_ver_feats10=convolution(trainDir,Centers,'VER',015,10);
P15_hzv_feats10=convolution(trainDir,Centers,'HZV',015,10);




