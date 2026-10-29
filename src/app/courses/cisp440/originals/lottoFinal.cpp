#include <iostream>
using namespace std;

void printingLotto(int nums[],int powerBall,int boundpBall, int boundWin, int numWins, bool pBallStatus){
int countings =0;
// 0,0
  if(numWins == 0 && !pBallStatus){
    for(int i=1; i <= boundWin; ++i){
        if(i != nums[0] && i != nums[1] && i != nums[2] && i != nums[3]&& i != nums[4]){
            for(int j = i; j <= boundWin;++j){
                if(j != nums[0] && j != nums[1] && j != nums[2] && j != nums[3]&& j != nums[4] && j!=i){
                    for(int k = j;k <= boundWin;++k){
                        if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]&& k != j && k!=i){
                            for(int m = k; m <= boundWin; ++m){
                                if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k && m!= j && m!=i){
                                    for(int n = m; n <= boundWin; ++n) {
                                        if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k && n!= j && n!=i){
                                            for(int o = 1; o <= boundpBall; ++o){
                                                if(o != powerBall){
                                                    clog << "{"<<i << ","<< j << "," << k << "," << m <<"," << n  << "}, " << o<< endl;
                                                    ++countings;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 0,1
  if(numWins == 0 && pBallStatus){
    for(int i=1; i <= boundWin; ++i){
        if(i != nums[0] && i != nums[1] && i != nums[2] && i != nums[3]&& i != nums[4]){
            for(int j = i; j <= boundWin;++j){
                if(j != nums[0] && j != nums[1] && j != nums[2] && j != nums[3]&& j != nums[4] && j!=i){
                    for(int k = j;k <= boundWin;++k){
                        if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]&& k != j && k!=i){
                            for(int m = k; m <= boundWin; ++m){
                                if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k && m!= j && m!=i){
                                    for(int n = m; n <= boundWin; ++n) {
                                        if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k && n!= j && n!=i){
                                            clog << "{"<<i << ","<< j << "," << k << "," << m <<"," << n  << "}, " << powerBall<< endl;
                                            ++countings;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 1,0
  if(numWins == 1 && !pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = 1; j <= boundWin;++j){
            if(j != nums[0] && j != nums[1] && j != nums[2] && j != nums[3]&& j != nums[4]){
                for(int k = j;k <= boundWin;++k){
                    if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]&& k != j){
                        for(int m = k; m <= boundWin; ++m){
                            if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k && m!= j){
                                for(int n = m; n <= boundWin; ++n) {
                                    if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k && n!= j){
                                        for(int o = 1; o <= boundpBall; ++o){
                                            if(o != powerBall){
                                                clog << "{"<<nums[i-1] << ","<< j << "," << k << "," << m <<"," << n  << "}, " << o<< endl;
                                                ++countings;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 1,1
  if(numWins == 1 && pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = 1; j <= boundWin;++j){
            if(j != nums[0] && j != nums[1] && j != nums[2] && j != nums[3]&& j != nums[4]){
                for(int k = j;k <= boundWin;++k){
                    if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]&& k != j){
                        for(int m = k; m <= boundWin; ++m){
                            if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k && m!= j){
                                for(int n = m; n <= boundWin; ++n) {
                                    if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k && n!= j){
                                        clog << "{"<<nums[i-1] << ","<< j << "," << k << "," << m <<"," << n  << "}, " << powerBall << endl;
                                        ++countings;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 2,0
  if(numWins == 2 && !pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = 1;k <= boundWin;++k){
                if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]){
                    for(int m = k; m <= boundWin; ++m){
                        if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k){
                            for(int n = m; n <= boundWin; ++n) {
                                if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k){
                                    for(int o = 1; o <= boundpBall; ++o){
                                        if(o != powerBall){
                                            clog << "{"<<nums[i-1] << ","<< nums[j] << "," << k << "," << m <<"," << n  << "}, " << o<< endl;
                                            ++countings;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
  // 2, 1
  if(numWins == 2 && pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = 1;k <= boundWin;++k){
                if(k != nums[0] && k != nums[1] && k != nums[2] && k != nums[3]&& k != nums[4]){
                    for(int m = k; m <= boundWin; ++m){
                        if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4] && m!= k){
                            for(int n = m; n <= boundWin; ++n) {
                                if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m && n!= k){
                                    clog << "{"<<nums[i-1] << ","<< nums[j] << "," << k << "," << m <<"," << n  << "}, " << powerBall << endl;
                                    ++countings;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        cout << "COUNTINGS: "<<countings << endl;
  }


// 3,0
  if(numWins == 3 && !pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = j;k <= numWins;++k){
                for(int m = 1; m <= boundWin; ++m){
                    if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4]){
                        for(int n = m; n <= boundWin; ++n) {
                            if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m){
                                for(int o = 1; o <= boundpBall; ++o){
                                    if(o != powerBall){
                                        clog << "{"<<nums[i-1] << ","<< nums[j] << "," << nums[k+1] << "," << m <<"," << n  << "}, " << o<< endl;
                                        ++countings;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }

// 3, 1
  if(numWins == 3 && pBallStatus){
    for(int i=1; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = j;k <= numWins;++k){
                for(int m = 1; m <= boundWin; ++m){
                    if(m != nums[0] && m != nums[1] && m != nums[2] && m != nums[3]&& m != nums[4]){
                        for(int n = m; n <= boundWin; ++n) {
                            if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]&& n != m){
                                clog << "{"<<nums[i-1] << ","<< nums[j] << "," << nums[k+1] << "," << m <<"," << n  << "}, " << powerBall << endl;
                                ++countings;
                            }
                        }
                    }
                }
            }
        }
    }
        cout << "COUNTINGS: "<<countings << endl;
  }
// 4,0
  if(numWins == 4 && !pBallStatus){
    for(int i=3; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = j;k <= numWins;++k){
                for(int m = k; m <= numWins; ++m){
                    for(int n = 1; n <= boundWin; ++n) {
                        if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]){
                            for(int o = 1; o <= boundpBall; ++o){
                                if(o != powerBall){
                                    clog << "{"<<nums[i-3] << ","<< nums[j-2] << "," << nums[k-1] << "," << nums[m] <<"," << n  << "}, " << o<< endl;
                                    ++countings;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 4,1
  if(numWins == 4 && pBallStatus){
    for(int i=3; i <= numWins; ++i){
        for(int j = i; j <= numWins;++j){
            for(int k = j;k <= numWins;++k){
                for(int m = k; m <= numWins; ++m){
                    for(int n = 1; n <= boundWin; ++n) {
                        if(n != nums[0] && n != nums[1] && n!= nums[2] && n != nums[3]&& n != nums[4]){
                            clog << "{"<<nums[i-3] << ","<< nums[j-2] << "," << nums[k-1] << "," << nums[m] <<"," << n  << "}, " << powerBall<< endl;
                            ++countings;
                        }
                    }
                }
            }
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
// 5,0
  if(numWins == 5 && !pBallStatus){
    for(int l =1 ; l <= boundpBall; ++l){
        if(l != powerBall){
            clog << "{"<<nums[0] << ","<< nums[1] << "," << nums[2] << "," << nums[3] <<"," << nums[4]  << "}, " << l << endl;
            ++countings;
        }
    }
    cout << "COUNTINGS: "<<countings << endl;
  }
  // 5,1
  if(numWins == 5 && pBallStatus){
    clog << "{"<<nums[0] << ","<< nums[1] << "," << nums[2] << "," << nums[3] <<"," << nums[4]  << "}, " << powerBall<< endl;
    ++countings;
    cout << "COUNTINGS: "<<countings << endl;
  }

}

int main() {
  int ubNum, ubpNum,pBallNum,pNumA, pNumB,pNumC,pNumD,pNumE,numOfwin, numOfloss;
  bool pball;

  cin >> ubNum >> ubpNum;
  cin >>pNumA >> pNumB >> pNumC >> pNumD >> pNumE >> pBallNum;
  cin >> numOfwin >> pball;

  numOfloss = 5-numOfwin;

  int winBalls[5];
  winBalls[0] =  pNumA;
  winBalls[1] =  pNumB;
  winBalls[2] =  pNumC;
  winBalls[3] =  pNumD;
  winBalls[4] =  pNumE;

  if(numOfloss + 5 > ubNum){
    cout << "WRONG INPUT: OUT OF BOUND" <<endl;
    return -1;
  }else
    printingLotto(winBalls,pBallNum,ubpNum, ubNum, numOfwin,pball);

  return 0;
}
