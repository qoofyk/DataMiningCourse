/*########################################################*/
//  Name:YUANKUN FU
//  Course name: DataMining
//  Homework Number: 1
//  Brief desc of the file: ReadMe
/*########################################################*/

run command like this:
make clean
make
./eclat /home/fuyuan/DataMining/HW01/dataset.txt 0.33 0.1

first argument is minimum support, should be [0,1]
second argument is minimum confidence, should be [0,1]

Then look at the current directory,
Frequent Itemsets.txt
Maximal Frequent Itemsets.txt

are generated.

in head.h
#define INDEX_ARRAY_SIZE 1000
I define the max number of different item could not exceed 1000
if too many item , we could set this number
