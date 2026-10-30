#include <cstring>
#include <fstream>
#include <iostream>
using namespace std;

struct DoubleNode {
  string data;
  DoubleNode *next;
  DoubleNode *prev;
};

DoubleNode *createNode(string &data);
DoubleNode *createNode(string &data) {
  DoubleNode *nn = new DoubleNode;
  nn->data = data;
  nn->next = NULL;
  nn->prev = NULL;
  return nn;
}

void insertNode(DoubleNode **head, string data);
void insertNode(DoubleNode **head, string data) {
  DoubleNode *nn = createNode(data);

  if (*head == NULL) {
    *head = nn;
  } else if (data < (*head)->data) {
    nn->next = *head;
    (*head)->prev = nn;
    *head = nn;
  } else {
      DoubleNode *curr = *head;
      while(curr->next != NULL && data > curr->next->data){
        curr = curr->next;
      }
      nn->next = curr->next;
      if (curr->next != NULL){
        curr->next->prev = nn;
      }
      curr->next =nn;
      nn->prev = curr;
  }
}

void deleteNode(DoubleNode **head, string nameToDelete);
void deleteNode(DoubleNode **head, string nameToDelete) {
    if(*head == NULL){
        return;
    }
    DoubleNode *curr = *head;
    while (curr != NULL){
        if(curr->data == nameToDelete){
            if(curr->prev != NULL){
                curr->prev->next = curr->next;
            }
            else {
                *head =curr->next;
            }
            if (curr->next != NULL){
                curr->next->prev = curr ->prev;
            }
            delete curr;
            return;
        }
        curr = curr->next;
    }
}

string toLowerCase(string data){
    for (int i =0 ; i < data.length(); i++){
        data[i] = tolower(data[i]);
    }
    return data;
}

void display(DoubleNode *head);
void display(DoubleNode *head) {
  DoubleNode *curr = head;
  while (curr != NULL) {
    cout << curr->data << endl;
    curr = curr->next;
  }
}

void writeToFile(DoubleNode *head);
void writeToFile(DoubleNode *head) {
  ofstream outFile("output.txt");
  if (!outFile) {
    cerr << "Error: opening output.txt" << endl;
  } else {
    DoubleNode *curr = head;
    while (curr != NULL) {
      outFile << curr->data << endl;
      curr = curr->next;
    }
    outFile.close();
  }
}

int main() {
  DoubleNode *head;
  head = NULL;

  string fName = "input.txt";
  ifstream inputFile(fName.c_str());

  if (!inputFile) {
    cerr << "Error: Unable to open input file " << endl;
    return 1;
  }

  string Dname;
  while (getline(inputFile, Dname)) {
    if (Dname.find("add") == 0) {
      string nameToAdd = Dname.substr(4);
      nameToAdd.erase(nameToAdd.find_last_not_of("\r\n") + 1);
      insertNode(&head, (toLowerCase(nameToAdd)));
    } else if (Dname.find("delete") == 0) {
      string nameToDelete = Dname.substr(7);
      nameToDelete.erase(nameToDelete.find_last_not_of("\r\n") + 1);
      deleteNode(&head, (toLowerCase(nameToDelete)));
    }
  }

  writeToFile(head);
  display(head);

  inputFile.close();

  while (head != NULL) {
    DoubleNode *temp = head;
    head = head->next;
    delete temp;
  }
  return 0;
}
