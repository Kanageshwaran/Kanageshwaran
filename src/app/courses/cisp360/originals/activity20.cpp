#include<iostream>
#include<iomanip>
using namespace std;
int sumOfNum(char serialNum[]);

int main()
{
    char serialNum[25]={0};
    int total=0;
    cout<<"Enter a series of digits with no spaces between them :";
    cin >>serialNum;

    total = sumOfNum(serialNum);
    cout << total;
    return 0;

}
int sumOfNum(char serialNum[])
{
    int len = 0 ,num[25],sum = 0 ;;
    for(int i =0;serialNum[i] != '\0' && i < 25;i++)
        len++;

     for(int i=0;i<= (len-1) ;i++){
        if(isdigit(serialNum[i]))
        {
        num[i] = static_cast<int>(serialNum[i])-48;
        sum += num[i];
        }
     }
     return sum;
}
