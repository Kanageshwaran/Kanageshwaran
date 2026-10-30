#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void swaping(char *a1,char *a2){
    char temp[10];
    strcpy(temp, a1);
    strcpy(a1,a2);
    strcpy(a2,temp);
}

int main(){
    char arr[2][10];
    char *ptr_arr[4];
    printf("Insert two names: \n");
    scanf("%s", arr[0]);
    scanf("%s", arr[1]);
    char a[10];
    char b[10];
    printf("\nInsert another name: ");
    scanf("%s", a);
    printf("\nInsert another name: ");
    scanf("%s", b);
    ptr_arr[0] = arr[0];
    ptr_arr[1] = &a[0];
    ptr_arr[2] = arr[1];
    ptr_arr[3] = &b[0];

    char *temp;
    temp = ptr_arr[1];
    ptr_arr[1] = ptr_arr[3];
    ptr_arr[3] =temp;

    swaping(ptr_arr[0],ptr_arr[2]);
    printf("Original: \n");
    for(int i =0; i < 2; i++){
        printf("%s\n", arr[i]);
    }
    printf("\narray: \n");
    for(int i =0; i < 4; i++){
        printf("%s\n", ptr_arr[i]);
    }
    printf("\n");
    return 0;
}
