/*########################################################*/
//  Name:YUANKUN FU
//  Course name: DataMining
//  Homework Number: 1
//  Brief desc of the file: function.C
/*########################################################*/

#include <head.h>

// find the common element in two vector
vector <int> FindCommon(vector <int> & a, vector <int> & b){
    int i = 0;
    int j = 0 ;
    int nA = a.size();
    int nB = b.size();
	vector<int> vec_comm;
	// count = 0;

    while (i < nA && j < nB) {
        if (a[i] < b[j])
            ++i ;
        else if(a[i] == b[j])
        {
			vec_comm.push_back(a[i]);
            ++i ;
            ++j ;
        }
        else// a[i] > b[j]
            ++j ;
    }

    //count = vec_comm.size();
	return vec_comm;
}

int FindCommon2(vector <int> & a, vector <int> & b){
    int i = 0;
    int j = 0 ;
    int nA = a.size();
    int nB = b.size();
	//vector<int> vec_comm;
	int count = 0;

    while (i < nA && j < nB) {
        if (a[i] < b[j])
            ++i ;
        else if(a[i] == b[j])
        {
			count++;
            ++i ;
            ++j ;
        }
        else// a[i] > b[j]
            ++j ;
    }

    //count = vec_comm.size();
	return count;
}

// get_a_candidate_frequent_item_set, a.last < b.last
vector <int> get_a_candidate_id(vector <int> & a, vector <int> & b){
	int i = 0;
    int nA = a.size();
    int nB = b.size();
    vector <int> result;
    int flag = 0;

    //cout << "nA = " << nA << endl;
    //cout << "nB = " << nB << endl;
    if( nA != nB){
      //cout << "Here1" << endl;
      flag = 0;
    }
    else{
		for (i=0;i<(nA-1);i++){
			if (a[i]!=b[i]) {
				flag =0;
				result.push_back(-1);
				//cout << "Here2" << endl;
			  	break;
			}
		}
		//cout << "Here1" << endl;
		//cout <<"i=" <<i<<endl;
		if (i==(nA-1)) flag=1;
    }

    //cout << "flag="<<flag << endl;
    if( flag == 0){
    	result.push_back(-1);
    }
    else if (flag == 1){
    	result = a;
      	result.push_back(*(b.end()-1));
    }
    else{
    	printf("Error!\n");
    }
    return result;
}

// prune whether a is valid to be a freq_item
// ida: last_dimension_start_id; idb: current_dimension_start_id;
vector <int> prune(vector <int> & a,  int ida,  int idb, vector < eclat_struct_t > & eclat_struct, vector < freq_item_struct_t > & all, GV gv){
	vector <int> result;
	vector <int> v,temp_transaction_id;
	vector <int>::iterator p;
	int i,j;
	int flag=0, tempsonflag = 0; //0:not exist; 1:exist
	int mysup=0;
	int start_id = *(a.begin());
	v=a;

	// check whether all immediat sons of a are valid
	for(j=1;j<=(int)a.size();j++){
		v=a;
		p=v.end()-j;
		v.erase(p);
		//cout << "v.size = "<< v.size() << " all.size= "<< all.size() <<endl;

		// whether last_dimension has v
		tempsonflag = 0;
		for(i=ida;i<idb;i++){
			if( equal(v.begin(), v.end(), all[i].freq_item_id.begin()) ) { // if has
				tempsonflag = 1;
				break; //
			}
		}

		if(tempsonflag == 0) { // if this son not exist
			flag = 0;
			break;
		}

		if((j==(int)(a.size()))&&(tempsonflag==1)) {
			flag=1;
			break;
		}

		v=a;

	}

	// cout << "Here 1 flag = " << flag <<endl;
	if(flag==1){
			// v and i from the break point of for-loop
			// cout << "i=" << i << endl;
			// cout << "v.size = "<< v.size() <<endl;
			// cout << "*p=" << *p <<endl;
 			temp_transaction_id = FindCommon(eclat_struct[start_id-1].eclat_transaction_id,all[i].freq_transaction_id);
 			mysup = temp_transaction_id.size();
 			// printf("mysup=%d,temp_transaction_id.size=%d\n",mysup,(int)temp_transaction_id.size());
 			//cout << temp_transaction_id.size() << endl;
 			// cout << (float)mysup/gv->total_transaction_number << endl;
			if((float)mysup/gv->total_transaction_number>=gv->minsup) {
				result=temp_transaction_id;
			}
			else{
				result.push_back(-1);
			}
	}
	else
		result.push_back(-1);

	return result;
}


// Max_freq_prune

