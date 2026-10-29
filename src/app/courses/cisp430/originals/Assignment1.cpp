#include <fstream>
#include <iostream>
#include <string>
using namespace std;

struct Node {
  string name;
  Node *next;
  Node *prev;
};

Node *createNode(const string &name) {
  Node *newNode = new Node;
  newNode->name = name;
  newNode->next = NULL;
  newNode->prev = NULL;
  return newNode;
}

void insertNode(Node **head, const string &name) {
  Node *newNode = createNode(name);
  if (*head == NULL) {
    *head = newNode;
  } else if (name < (*head)->name) {
    newNode->next = *head;
    (*head)->prev = newNode;
    *head = newNode;
  } else {
    Node *current = *head;
    while (current->next != NULL && name > current->next->name) {
      current = current->next;
    }
    newNode->next = current->next;
    if (current->next != NULL) {
      current->next->prev = newNode;
    }
    current->next = newNode;
    newNode->prev = current;
  }
}

void deleteNode(Node **head, const string &name) {
  if (*head == NULL) {
    return;
  }

  Node *current = *head;
  while (current != NULL) {
    if (current->name == name) {
      if (current->prev != NULL) {
        current->prev->next = current->next;
      } else {
        *head = current->next;
      }
      if (current->next != NULL) {
        current->next->prev = current->prev;
      }
      delete current;
      return;
    }
    current = current->next;
  }
}

void writeToFile(Node *head) {
  ofstream outFile("output.txt");
  if (!outFile) {
    cerr << "Error: opening output.txt" << endl;
  } else {
    Node *current = head;
    while (current != NULL) {
      outFile << current->name << endl;
      current = current->next;
    }
    outFile << "=============" << endl;

    Node *tail = head;
    while (tail != NULL && tail->next != NULL) {
      tail = tail->next;
    }
    while (tail != NULL) {
      outFile << tail->name << endl;
      tail = tail->prev;
    }
    outFile.close();
  }
}

int main() {
  Node *head = NULL;
  ifstream inFile("input.txt");
  if (!inFile) {
    cerr << "Error: opening input.txt" << endl;
  } else {
    string line;
    while (getline(inFile, line)) {
      if (line.find("delete") == 0) {
        string nameToDelete = line.substr(7);
        nameToDelete.erase(nameToDelete.find_last_not_of("\r\n") + 1);
        deleteNode(&head, nameToDelete);
      } else {
        line.erase(line.find_last_not_of("\r\n") + 1);
        insertNode(&head, line);
      }
    }
    inFile.close();
    writeToFile(head);
    while (head != NULL) {
      Node *temp = head;
      head = head->next;
      delete temp;
    }
  }
  return 0;
}
