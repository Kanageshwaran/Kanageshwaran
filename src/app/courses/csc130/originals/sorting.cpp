#include <iostream>
using namespace std;
void Merge(int mergeCp[],int head, int tail){
    int sizeArr = (tail -head)+1;
    int b[sizeArr];
    int i = head;
    int mid = (head + tail) / 2;
    int k=0;
    int j = mid +1;
    while(k < sizeArr){
        if((i<=mid)&&(mergeCp[i]<mergeCp[j]))
            b[k++] = mergeCp[i++];
        else
            b[k++] = mergeCp[j++];
    }
    for (k = 0; k < sizeArr;k++){
        mergeCp[head +k] = b[k];
    }
}
void MergeSort(int mergeCp[], int head, int tail){
    if(head >= tail){
        return;
    }
    int middle = ((head + tail)/2);
    MergeSort(mergeCp,head, middle);
    MergeSort(mergeCp, middle + 1,tail);
    Merge(mergeCp, head, tail);
}

int part(int quickCp[],int head, int tail){
    int pivot = quickCp[head];
    int num =0;
    for(int i = head +1; i< tail; i++){
        if(quickCp[i] <= pivot){
            num++;
        }
    }
    int pivotI = head + num;
    int temp = quickCp[pivotI];
    quickCp[pivotI] = quickCp[head];
    quickCp[head] = temp;
    int i= head;
    int j = tail;
    while(i < pivotI && j > pivot){
        while(quickCp[i] <= pivot){
            i++;
        }
        while(quickCp[j] > pivot){
            j--;
        }
        if(i < pivotI && j > pivotI){
            int temp = quickCp[i++];
            quickCp[i] = quickCp[j--];
            quickCp[j] = temp;
        }
    }
    return pivotI;

}

void QuickSort(int quickCp[],int head, int tail){
    if(head <  tail){
    int p =  part(quickCp,head, tail);
    QuickSort(quickCp,head,p-1);
    QuickSort(quickCp,p+1,tail);
    }
    return;
}
void counting(int radixCp, int n, int exp){
    int output[n];
    int counts[10] = {};
    for(int i=0; i < n; i++){
        counts[(radixCp[i]/exp)%10]++;
    }
    for(int i=1; i  < 10; i++){
        counts[i] += counts[i-1];
    }
    for(int i=n-1; i >= 0; i--){
        output[counts[(radixCp[i]/exp)%10] -1] = radix[i];
        counts[(radixCp[i]/exp)%10]--;
    }
    for(int i =0; i < n ; i++){
        radixCp[i] = output[i];
    }
}

void RadixSort(int  radixCp[], int num){
        int maxiu = radix[0];
        for(int i =1 ; i < n; i++){
            if(radixCp > maxiu)
            {
                maxiu = radixCp[i];
            }
        }
        for(int exp = 1 ; maxiu / exp > 0; exp *= 10){
            counting(arr,n,exp);
        }
}


int main(){
    int num = 0;
    cout << "Please enter how many numbers to sort: " << endl;
    cin >> num;
    int arr[num] = {};
    int mergeCp[num] = {};
    int quickCp[num] = {};
    int radixCp[num] = {};
    cout << "Please insert list of numbers: " << endl;
    for(int i =0; i < num; i++){
        cin >> arr[i];
    }
    for(int i =0; i < num ; i ++){
        mergeCp[i] = arr[i];
        quickCp[i] = arr[i];
        radixCp[i] = arr[i];
    }
    cout << endl << "Using Merge Sort" << endl;
    MergeSort(mergeCp, 0, num-1);
    for(int i =0 ; i < num; i++){
        cout << mergeCp[i] << " ";
    }
    cout << endl << "Using Quick Sort" << endl;
    QuickSort(quickCp, 0 , num -1);
    for(int i =0 ; i < num; i++){
        cout << quickCp[i] << " ";
    }
    cout << endl << "Using Radix Sort" << endl;
    RadixSort(radixCp);
    for(int i = 0 ; i < num; i++){
        cout <<  radixCp[i] << " ";
    }
    return 0;
}
