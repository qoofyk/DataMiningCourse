clc;
clear all;

totalDir = '..\10percent_total\';
w=6;numpatch=200;numClusters=1000;
P10_centers6=myclustering(totalDir,w,numpatch,numClusters);

w=8;numpatch=200;numClusters=1000;
P10_centers8=myclustering(totalDir,w,numpatch,numClusters);

w=10;numpatch=200;numClusters=1000;
P10_centers10=myclustering(totalDir,w,numpatch,numClusters);

totalDir = '..\08percent_total\';
w=6;numpatch=200;numClusters=1000;
P8_centers6=myclustering(totalDir,w,numpatch,numClusters);

w=8;numpatch=200;numClusters=1000;
P8_centers8=myclustering(totalDir,w,numpatch,numClusters);

w=10;numpatch=200;numClusters=1000;
P8_centers10=myclustering(totalDir,w,numpatch,numClusters);
