/*########################################################*/
//  Name:YUANKUN FU
//  Course name: DataMining
//  Homework Number: 1
//  Brief desc of the file: main.C
/*########################################################*/

#include <iostream>
#include <iterator>
#include <fstream>
#include <vector>
#include <algorithm>
#include <string>
#include <stdio.h>
#include <stdlib.h>

using namespace std;
#define ADDRESS "./dataset.txt"
#define INDEX_ARRAY_SIZE 1000
// void input(ifstream myfile, vector <int> transaction_id,	vector <int> item_id);

struct eclat_struct_t{
	vector<int> eclat_item_id;
	vector<int> eclat_transaction_id;
};

struct freq_item_struct_t{
	vector<int> freq_item_id;
	vector<int> freq_transaction_id;
	int support;
};

typedef struct gv_t {
	float minsup;
	float minconf;
	int total_transaction_number,itemsize;
}* GV;

struct max_freq_item_struct_t{
	vector<int> freq_item_id;
	int support;
};

//association rule structure
struct ar_struct_t{
	vector<int> left;
	vector<int> right;
	float confidence;
};

vector <int> FindCommon(vector <int> & a, vector <int> & b);
vector <int> get_a_candidate_id(vector <int> & a, vector <int> & b);
vector <int> prune(vector <int> & a,  int ida,  int idb, vector < eclat_struct_t > & eclat_struct, vector < freq_item_struct_t > & all, GV gv);
int FindCommon2(vector <int> & a, vector <int> & b);
