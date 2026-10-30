#include <iostream>
#include <stack>
#include <queue>
#include <string>
using namespace std;

class Stack{
private:
    stack<char>stacking;
public:
    void push(char c){
        stacking.push(c);
    }
    char pop(){
        char c = stacking.top();
        stacking.pop();
        return c;
    }
    char peek(){
        return stacking.top();
    }
    bool isEmpty(){
        return stacking.empty();
    }
};

class Queue{
private:
    queue<char>editQ;
public:
    void enqueue(char c){
        editQ.push(c);
    }
    char dequeue(){
        char c = editQ.front();
        editQ.pop();
        return c;
    }
    bool isEmpty(){
        return editQ.empty();
    }
};

bool isOperator(char operat){
    return operat == '+' || operat == '-' || operat == '*' || operat == '/';
}

int tool(char operat){
    if (operat == '+' || operat == '-'){
        return 1;
    }
    else if (operat == '*' || operat == '/'){
        return 2;
    }
    else {
        return 0;
    }
}
string inTopost(string infix){
    Stack OPS;
    Queue output;
    string postfix = "";

    for(char& c: infix){
        if(isalnum(c)){
            postfix+= c;
        }
        else if(c == '('){
            OPS.push(c);
        }
        else if(c == ')'){
            while(!OPS.isEmpty()&& OPS.peek() != '('){
                postfix += OPS.pop();
            }
            OPS.pop();
        }
        else if(isOperator(c)){
            while(!OPS.isEmpty()&&tool(OPS.peek())>=tool(c)){
                postfix += OPS.pop();
            }
            OPS.push(c);
        }
    }
    while (!OPS.isEmpty()){
        postfix += OPS.pop();
    }
    return postfix;
}

double resultPost(string postfix){
    stack<double>s;
    for(char& c : postfix){
        if (isdigit(c)){
            s.push(c -'0');
        }
        else if(isOperator(c)){
            double b = s.top();
            s.pop();
            double a = s.top();
            s.pop();
            double result;
            switch (c){
            case '+':
                result = a + b;
                break;
            case '-':
                result = a - b;
                break;
            case '*':
                result = a * b;
                break;
            case '/':
                result = a / b;
                break;
            }
            s.push(result);
        }
    }
    return s.top();
}

int main(){
    string infix = "(3 + 4 * (2 - 1)) / (5 - 2) + (8 - 6) * (4 + 2) / 2";
/*
    cout << "Please insert the entire expression: " << endl;
    cin >> infix;
    cout << "You wrote: " << infix << endl;
*/
    string postfix;
    double answer;
    postfix = inTopost(infix);
    cout << "postfix expression is: " << postfix << endl;

    answer = resultPost(postfix);
    cout << "Answer: " << answer << endl;
    return 0;
}
