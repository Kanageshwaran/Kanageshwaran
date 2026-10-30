#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <sys/wait.h>

void* func1(void* arg){
    char* fname = (char*) arg;
    pid_t pid = fork();
    if(pid == 0){
        char lname[50];
        printf("Enter lastname: ");
        scanf("%s", lname);
        char name[100];
        snprintf(name,sizeof(name), "%s %s", fname, lname);
        printf("Fullname: %s\n", name);
        exit(0);
    }
    wait(NULL);
    pthread_exit(NULL);
}
void* func2(void* arg){
    pid_t pid =fork();
    if(pid == 0){
        execlp("ps",NULL);
    }
    else{
        int stat;
        waitpid(pid, &stat, NULL);
        int* retStat = malloc(sizeof(int));
        *retStat = WEXITSTATUS(stat);
        pthread_exit(retStat);
    }
}

int main(int argc, char* argv[]){
    pthread_t t1, t2;
    pthread_create(&t1,NULL,func1, argv[1]);
    pthread_join(t1,NULL);

    int* stat;
    pthread_create(&t2,NULL,func2, NULL);
    pthread_join(t2, (void**) &stat);

    if(stat != NULL){
        printf("Thread t2 child process status is : %d\n", *stat);
        free(stat);
    }
    else {
       fprintf(stderr, "Failure\n");
    }
    return 0;
}
