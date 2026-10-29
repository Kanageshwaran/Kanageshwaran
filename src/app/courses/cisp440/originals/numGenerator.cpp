#include <iostream>
using namespace std;


void printingLotto(){
    int nums[] = {1,2,5,7,8};
    int upLotto = 10;
    int numWins = 3;
    int numLoss = 5-numWins;
    int countNums =0;
    int powerBallNum = 6;
    int UBpowerBalL = 10;
    bool PBStatus =0;


    for(int i=1; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = j;k <= numWins;++k){
               // for(int l = 1; l <= numLoss; ++l){
                    for(int m = 1; m <= upLotto; ++m){
                        if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4]){
                            for(int n = m; n <= upLotto; ++n) {
                                if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m){
                                    for(int o = 1; o <= UBpowerBalL; ++o){
                                        if(o != powerBallNum){
                                            cout << "{"<<nums[i-1] << ","<< nums[j] << "," << nums[k+1] << "," << m <<"," << n  << "}, " << o<< endl;
                                            ++countNums;
                                        }
                                    }
                                }
                            }
                        }
                    }
                //}
            }
        }
    }
    cout << "COUNT: " << countNums << endl;
}

int main(){

    printingLotto();

    return 0;
}
