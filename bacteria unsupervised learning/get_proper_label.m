function [ FINALTRAINLABEL, train_index,test_index] = get_proper_label(numgen )
% sort to get correct order of lable
[Trainnum,TrainLable] = xlsread('../TrainImageLabels.xlsx','A2:B607');
[Testnum,TestLable] = xlsread('../SubmissionFile.xls','A2:B1228');

total=[Trainnum',Testnum'];
[newtotal,index]=sort(total);

newTrainnum=zeros(1,606);
newTestnum=zeros(1,1227);
testc=1;
trainc=1;
for j=1:1833
    if(index(j)>606)
        newTestnum(testc)=j;
        testc=testc+1;
    else
        newTrainnum(trainc)=j;
        trainc=trainc+1;
    end
end
finalTestnum=newTestnum';
finalTrainnum=newTrainnum';

%convert char string to number
[FileName,Lable] = xlsread('../TrainImageLabels.xlsx','A2:B607');
Ytrain=char(Lable);
% Ytrain=cellfun(@str2num, Lable);
i=1;
newYtrain=zeros(606,1);
for i=1:606
    if strcmp(Ytrain(i,:),'ecoli        ')
        newYtrain(i)=1;
    elseif  strcmp(Ytrain(i,:),'salmonella   ')
        newYtrain(i)=2;
    elseif  strcmp(Ytrain(i,:),'staphylococus')
        newYtrain(i)=3;
    elseif strcmp(Ytrain(i,:),'listeria     ')
         newYtrain(i)=4;
    else
        newYtrain(i)=0;
    end
end

train_index=zeros(numgen*606,1);
for i = 1:numgen
    train_index((1+606*(i-1)):(606+606*(i-1)),:) = finalTrainnum+ones(606,1)*1833*(i-1);
end

test_index=zeros(numgen*1227,1);
for i = 1:numgen
    test_index((1+1227*(i-1)):(1227+1227*(i-1)),:) = finalTestnum+ones(1227,1)*1833*(i-1);
end

FINALTRAINLABEL=repmat(newYtrain,numgen,1);
end

