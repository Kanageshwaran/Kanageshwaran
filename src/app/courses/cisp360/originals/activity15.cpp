#include <iostream>
#include <fstream>
using namespace std;


int getTotal(const int ARR[][20], const int NUM_ROWS);
double getAverage(const int ARR[][20], const int NUM_ROWS);
int getRowTotal(const int ARR[][20], const int ROW,const int NUM_ROWS);
int getColumnTotal(const int ARR[][20], const int COL,const int NUM_ROWS);
int getHighestInRow(const int ARR[][20], const int ROW,const int NUM_ROWS);
int getLowestInRow(const int ARR[][20], const int row,const int NUM_ROWS);


int main(){
    const int NUM_ROWS = 5;
    const int NUM_COLS = 20;
    int data[NUM_ROWS][NUM_COLS];
    int rowIndex;
    int colIndex;
    ifstream reader("randomNumbers.txt");
        if(!reader){
            cout<<"Some error happened while opening the file.\n";
            return -1;
        }

    for(int row=0; row< NUM_ROWS; row++){
        for(int col=0; col< NUM_COLS; col++){
             if( ! (reader>>data[row][col]) ){
                cout<<"Incomplete readings,\n";
                cout<<"The program would terminate.\n";
                reader.close();
                return -1;
            }
        }
    }
cout<<"Data was successfully stored.\n";
        reader.close();

        cout<<"Please enter the row index you want to use.\n";
        cout<<"Your row: ";
        cin>>rowIndex;
        while(rowIndex<0 || rowIndex>= NUM_ROWS){
            cout<<"Your number must be bounded by total rows.\n";
            cout<<"Your row: ";
            cin>>rowIndex;
        }
        cout<<endl<<"Please enter the col index you want to use.\n";
        cout<<"Your column: ";
        cin>>colIndex;
        while(colIndex<0 || colIndex>= NUM_COLS){
            cout<<"Your number must be bounded by total columns\n";
            cout<<"Your column: ";
            cin>>colIndex;
        }
        cout<<endl<<"  The total of the data: "<<getTotal(data,NUM_ROWS)
            <<std::endl;
        cout<<"The average of the data: "<<getAverage(data,NUM_ROWS)
            <<std::endl;
        cout<<"     The total of row "<<rowIndex+1<<": "
            << getRowTotal(data,rowIndex,NUM_ROWS)<<std::endl;
        cout<<"  The total of column "<<colIndex+1<<": "
            << getColumnTotal(data,colIndex,NUM_ROWS)<<std::endl;
        cout<<"   The highest in row "<<rowIndex+1<<": "
            << getHighestInRow(data,rowIndex,NUM_ROWS)<<std::endl;
        cout<<"    The lowest in row "<<rowIndex+1<<": "
            << getLowestInRow(data,rowIndex,NUM_ROWS)<<std::endl;
        return 0;
    }

int getTotal(const int ARR[][20], const int NUM_ROWS){
        int total = 0;
        for(int row=0; row< NUM_ROWS; row++){
            for(int col=0; col< 20; col++){
                total += ARR[row][col];
            }
        }
        return total;
    }
double getAverage(const int ARR[][20], const int NUM_ROWS){
        double avg = 1.0 * getTotal(ARR,NUM_ROWS) / (20*NUM_ROWS);

        return avg;
    }

int getRowTotal(const int ARR[][20], const int ROW,
                     const int NUM_ROWS){

        if(ROW >= NUM_ROWS || ROW<0){
            cout<<"Invalid row number inside getRowTotal.\n";
            cout<<"The function would return 0.\n";
            return -1;
        }


        int total = 0;

        for(int col=0; col< 20; col++){
            total += ARR[ROW][col];
        }

        return total;
    }


int getColumnTotal(const int ARR[][20], const int COL,
                     const int NUM_ROWS){

        if(COL >= 20 || COL<0){
            cout<<"Invalid column number inside getColumnTotal.\n";
            cout<<"The function would return 0.\n";
            return -1;
        }
        int total = 0;

        for(int row=0; row< NUM_ROWS; row++){
            total += ARR[row][COL];
        }
        return total;
    }
int getHighestInRow(const int ARR[][20], const int ROW,
                     const int NUM_ROWS){

        if(ROW >= NUM_ROWS || ROW<0){
            cout<<"Invalid row  number inside  getHighestInRow.\n";
            cout<<"The function would return 0.\n";
            return -1;
        }
        int highest = ARR[ROW][0];
        for(int col=1; col< 20; col++){
            if(highest < ARR[ROW][col]){
                highest = ARR[ROW][col];
            }
        }
        return highest;
    }
int getLowestInRow(const int ARR[][20], const int ROW,
                     const int NUM_ROWS){

        if(ROW >= NUM_ROWS || ROW<0){
            cout<<"Invalid row  number inside  getLowestInRow.\n";
            cout<<"The function would return 0.\n";
            return -1;
        }
        int lowest = ARR[ROW][0];
        for(int col=1; col< 20; col++){
            if(lowest > ARR[ROW][col]){
                lowest = ARR[ROW][col];
            }
        }
        return lowest;
    }
