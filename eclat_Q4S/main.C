/*########################################################*/
//  Name:YUANKUN FU
//  Course name: DataMining
//  Homework Number: 1
//  Brief desc of the file: main.C
/*########################################################*/
#include <head.h>

int main (int argc, char **argv) {
	string file_path;
	float mysup;
	//float myconf;

	GV gv;

	if(argc != 4) {
		fprintf(stderr, "Usage: %s file_path, minsup, minconf\n", argv[0]);
		exit(1);
	}

	gv = (GV) malloc(sizeof(*gv));
	file_path=argv[1];
	gv->minsup=stof(argv[2]);
	gv->minconf=stof(argv[3]);

	ifstream myfile (file_path);

//---------------------INPUT----------------------------------------

	// ifstream myfile (ADDRESS);
	// minsup=0.5;
	// minconf=0.1;

	if (!myfile.is_open()) {
        cout << "File is not existing!" << endl;
        exit(1);
    }

    vector <int> transaction_id;
	vector <int> org_item_id;
	//input(myfile,&transaction_id,&transaction_id);

	int temp;
	int pos,pos1,pos2;
	string buffer;

	while ( !myfile.eof() ){

		myfile >> buffer;

		if(buffer.substr(0,1)=="T") {
			pos = buffer.find_last_of(":");
			temp = stoi(buffer.substr(1,pos-1));
			transaction_id.push_back(temp);
		}
		else if (buffer.substr(0,1)=="I") {

			while(buffer.find_first_of(",") != string::npos){
				pos1 = buffer.find_first_of("I");
				pos2 = buffer.find_first_of(",");
				temp = stoi(buffer.substr(pos1+1,pos2-pos1-1));
				org_item_id.push_back(temp);
				buffer = buffer.substr(pos2+1);
			}

			temp = stoi(buffer.substr(1));
			org_item_id.push_back (temp);
			org_item_id.push_back (-1); //end of one transaction
		}
		else{
			continue;
		}
	}

	gv->total_transaction_number = transaction_id.size();

	vector <int> item_id (org_item_id);

	int i,j,k;

   	std::sort(item_id.begin(), item_id.end() );
	std::vector<int>::iterator iter_end;
	iter_end = unique(item_id.begin(), item_id.end());
	item_id.erase(iter_end, item_id.end() );
	item_id.erase(item_id.begin());
	gv->itemsize = item_id.size();


	// for (std::vector<int>::iterator it = org_item_id.begin(); it!=org_item_id.end(); ++it)
 //      std::cout << ' ' << *it;
 //    std::cout << '\n';

   	myfile.close();

//---------------------make eclat chart----------------------------------------------

   	vector < eclat_struct_t > eclat_struct;
   	eclat_struct_t eclat_temp;

   	for (std::vector<int>::iterator ii = item_id.begin(); ii!=item_id.end(); ++ii){
   		eclat_temp.eclat_item_id.push_back(*ii); //i+1
   		k=1; // transaction_id
   		for( std::vector<int>::iterator jj = org_item_id.begin(); jj!=org_item_id.end(); ++jj) {
   			if (*jj == -1) k++;
   			if (*jj == *ii)
   				eclat_temp.eclat_transaction_id.push_back(k);
	   	}

		eclat_struct.push_back(eclat_temp);

	   	eclat_temp.eclat_item_id.clear();
	   	eclat_temp.eclat_transaction_id.clear();
   	}


   	// cout << "Eclat chart size = " << eclat_struct.size() << endl;

   	// for (std::vector<eclat_struct_t>::iterator i = eclat_struct.begin(); i!=eclat_struct.end(); ++i){
   	// 	cout << "****In "<< i - eclat_struct.begin() <<" colomn in Eclat chart size = " << (*i).eclat_transaction_id.size() << endl;
   	// 	// for( i = 0; i < eclat_struct[j].eclat_transaction_id.size(); i++ ) {
	   //  //       cout << eclat_struct[j].eclat_transaction_id[i] << "  ";
	   // 	// }
	   // 	// cout << endl;
   	// }


   	/****************Frequent Item***************************/

   	vector < freq_item_struct_t > all_freq_item;
   	int start_index[INDEX_ARRAY_SIZE];
   	freq_item_struct_t freq_temp;
   	int mysup_i;

   	for (i=0;i<INDEX_ARRAY_SIZE;i++){
   		start_index[i]=-1;
   	}

   	// get L1
   	start_index[1] = 0;
   	for ( j = 0; j < (int)eclat_struct.size(); j++ ){
   		mysup_i = eclat_struct[j].eclat_transaction_id.size();
   		mysup = (float) mysup_i / gv->total_transaction_number;
   		if( mysup >= gv->minsup){
   			freq_temp.support = mysup_i;
   			freq_temp.freq_item_id.push_back(j+1);
   			freq_temp.freq_transaction_id= eclat_struct[j].eclat_transaction_id;
   			all_freq_item.push_back(freq_temp);

   			freq_temp.freq_item_id.clear();
   			freq_temp.freq_transaction_id.clear();
		}
   	}

   	// for (vector<freq_item_struct_t>::iterator m = all_freq_item.begin(); m!=all_freq_item.end(); ++m){
   	// 	cout << "****I "<< (*m).freq_item_id[0] <<" has size = " << (*m).freq_transaction_id.size() << endl;
   	// }
   	// cout << all_freq_item.size() <<endl;

   	// get L2 and so on
   	start_index[2] = all_freq_item.size();
   	int current_total_size=all_freq_item.size();
   	for(i=2;i<=gv->itemsize;i++){
   		//all_freq_item get a index from [ start_index[i-1] , start_index[i] )
   		for (j = start_index[i-1]; j< (start_index[i]-1); j++){
   			for (k=j+1; k<start_index[i]; k++){
   				freq_temp.support=0;
   				freq_temp.freq_item_id = get_a_candidate_id(all_freq_item[j].freq_item_id,
   					all_freq_item[k].freq_item_id);
   				freq_temp.freq_transaction_id = prune(freq_temp.freq_item_id,
   					start_index[i-1],start_index[i],
   					eclat_struct,all_freq_item,gv);
   				freq_temp.support = freq_temp.freq_transaction_id.size();
   				// printf("id.size=%d,freq_temp.support=%d, i=%d, j=%d, k=%d\n",
   				// 	(int)(freq_temp.freq_item_id.size()),freq_temp.support, i, j, k);
				if(((int)freq_temp.freq_item_id.size() == i) && (freq_temp.freq_transaction_id[0] != -1)){
					all_freq_item.push_back(freq_temp);
				}
				freq_temp.freq_item_id.clear();
   				freq_temp.freq_transaction_id.clear();
   			}
   		}

   		if(current_total_size==(int)all_freq_item.size())
   			break;

   		current_total_size = all_freq_item.size();
   		start_index[i+1] = all_freq_item.size();

   	}

   	// show size
   	// for (vector<freq_item_struct_t>::iterator m = all_freq_item.begin(); m!=all_freq_item.end(); ++m){
   	// 	cout << "****Node "<< m-all_freq_item.begin() <<" has size = " << (*m).freq_transaction_id.size() << endl;
   	// }
   	// cout << all_freq_item.size() <<endl;

 	// display on console
   	int item_id_size;
 //   	for ( i = 0; i < (int)all_freq_item.size(); i++) {
	// 	item_id_size = all_freq_item[i].freq_item_id.size();
	// 	cout << "*********** # = " << i << " has size= "<<  item_id_size << " freq_item_id = {";
	// 	for (j = 0; j < item_id_size;j++){
	// 		if(j == item_id_size-1)
	// 			cout << "I" <<all_freq_item[i].freq_item_id[j];
	// 		else
	// 			cout << "I" <<all_freq_item[i].freq_item_id[j] << ",";
	// 	}

	//    	cout << "};Sup=" << all_freq_item[i].support << endl;
	// }

   	/* write frequent item to file*/
	ofstream outfile("./Frequent Itemsets.txt");
	for ( i = 0; i < (int)all_freq_item.size(); i++) {
		item_id_size = all_freq_item[i].freq_item_id.size();
		outfile <<"{";
		for (j = 0; j < item_id_size;j++){
			if(j == item_id_size-1)
				outfile << "I" <<all_freq_item[i].freq_item_id[j];
			else
				outfile << "I" <<all_freq_item[i].freq_item_id[j] << ",";
		}

	   	outfile << "};Sup=" << all_freq_item[i].support << endl;
	}
   	outfile.close();

   	//---------------------------------------------------------------------------------------------------

   	//-----------------------------Calc Maxium Frequent Item----------------------------------------------
   	vector <max_freq_item_struct_t> all_max_freq;
   	max_freq_item_struct_t max_freq_temp;
   	int common_element_counter=-1;
   	int depth_tree;

   	// find depth of the tree
   	for(i=1;i<INDEX_ARRAY_SIZE;i++){
   		//printf("%d\n", start_index[i]);
   		if(start_index[i]==(int)all_freq_item.size()){
   			//printf("i=%d\n",i);
   			depth_tree = i-1;
   			break;
   		}
   	}


   	int is_max = 1; // 1: true, this is a max_item; 0: this is not a max_item
   	for(i=1;i<=depth_tree;i++){
   		if( i == depth_tree){
   			for (j = start_index[i]; j< (start_index[i+1]); j++){
   				max_freq_temp.freq_item_id = all_freq_item[j].freq_item_id;
   				max_freq_temp.support = all_freq_item[j].support;
   				all_max_freq.push_back(max_freq_temp);
   			}
   			break;
   		}
   		//all_freq_item get a index from current dimension
   		for (j = start_index[i]; j< (start_index[i+1]); j++){
   			// current dimension: all_freq_item[j].freq_item_id
   			max_freq_temp.freq_item_id = all_freq_item[j].freq_item_id;
   			max_freq_temp.support = all_freq_item[j].support;
   			//all_freq_item get a index from next dimension [ start_index[i+1] , start_index[i+2] )
   			for (k=start_index[i+1]; k<start_index[i+2]; k++){
   				// next dimension: all_freq_item[k].freq_item_id, all_freq_item[k].freq_item_id.size()
   				common_element_counter=FindCommon2(max_freq_temp.freq_item_id,all_freq_item[k].freq_item_id);
   				if(common_element_counter > 0){
   					is_max = 0;
   					break;
   				}

   				if(k==(start_index[i+2]-1)) is_max=1;
   			}

   			if (is_max == 0) continue;
   			else if (is_max ==1){
   				all_max_freq.push_back(max_freq_temp);
   			}
   			else
   				printf("Error!\n");
   		}

   	}

   	//display on console
 //   	for ( i = 0; i < (int)all_max_freq.size(); i++) {
	// 	item_id_size = all_max_freq[i].freq_item_id.size();
	// 	cout << "*********** # = " << i << " has size= "<<  item_id_size << " freq_item_id = {";
	// 	for (j = 0; j < item_id_size;j++){
	// 		if(j == item_id_size-1)
	// 			cout << "I" <<all_max_freq[i].freq_item_id[j];
	// 		else
	// 			cout << "I" <<all_max_freq[i].freq_item_id[j] << ",";
	// 	}

	//    	cout << "};Sup=" << all_max_freq[i].support << endl;
	// }

   	/* write max frequent item to file*/
	ofstream outfile1("./Maximal Frequent Itemsets.txt");
	for ( i = 0; i < (int)all_max_freq.size(); i++) {
		item_id_size = all_max_freq[i].freq_item_id.size();
		outfile1 <<"{";
		for (j = 0; j < item_id_size;j++){
			if(j == item_id_size-1)
				outfile1 << "I" <<all_max_freq[i].freq_item_id[j];
			else
				outfile1 << "I" <<all_max_freq[i].freq_item_id[j] << ",";
		}

	   	outfile1 << "};Sup=" << all_max_freq[i].support << endl;
	}
   	outfile1.close();


  	return 0;
}
