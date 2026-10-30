#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node *left = NULL;
    Node *right = NULL;
    Node(int value) {
        data = value;
    }
};

class BinaryTree {
private:
Node *root;
Node *insertNodeRecursive(Node *current, int value) {
    if (current == NULL) {
        return new Node(value);
    }
    if (value < current->data) {
        current->left = insertNodeRecursive(current->left, value);
    }
    else{
        current->right = insertNodeRecursive(current->right, value);
    }
    return current;
}

Node *findMin(Node *node) {
    while (node->left != NULL) {
        node = node->left;
    }
    return node;
  }

Node *deleteNodeRecursive(Node *current, int value) {
    if (current == NULL) {
        return NULL;
    }
    if (value < current->data) {
        current->left = deleteNodeRecursive(current->left, value);
    }
    else if (value > current->data) {
        current->right = deleteNodeRecursive(current->right, value);
    }
    else {
        if (current->left == NULL && current->right == NULL) {
            delete current;
            return NULL;
      }
        else if (current->left == NULL) {
            Node *temp = current->right;
            delete current;
            return temp;
      }
      else if (current->right == NULL) {
            Node *temp = current->left;
            delete current;
            return temp;
      }
      else {
        Node *temp = findMin(current->right);
        current->data = temp->data;
        current->right = deleteNodeRecursive(current->right, temp->data);
      }
    }
    return current;
  }
void inOrderRecursive(Node *node) {
    if (node != NULL) {
        inOrderRecursive(node->left);
        cout << node->data << " ";
        inOrderRecursive(node->right);
    }
  }

void preOrderRecursive(Node *node) {
    if (node != NULL) {
        cout << node->data << " ";
        preOrderRecursive(node->left);
        preOrderRecursive(node->right);
    }
  }

void postOrderRecursive(Node *node) {
    if (node != NULL) {
        postOrderRecursive(node->left);
        postOrderRecursive(node->right);
        cout << node->data << " ";
    }
}

public:
    BinaryTree() {
        root = NULL;
    }
    void insert(int value) {
        root = insertNodeRecursive(root, value);
    }
    void remove(int value) {
        root = deleteNodeRecursive(root, value);
    }
    void inOrderTraversal() {
        cout << "In-order traversal: \n";
        inOrderRecursive(root);
        cout << endl;
    }
    void preOrderTraversal() {
        cout << "Pre-order traversal: \n";
        preOrderRecursive(root);
        cout << endl;
    }
    void postOrderTraversal() {
        cout << "Post-order traversal: \n";
        postOrderRecursive(root);
        cout << endl;
    }
};
class MaxHeap {
private:
  int *heap;
  int capacity;
  int size;

void maxHeapify(int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int largest = index;
    if (left < size && heap[left] > heap[largest]) {
        largest = left;
    }
    if (right < size && heap[right] > heap[largest]) {
        largest = right;
    }
    if (largest != index) {
        int temp = heap[index];
        heap[index] = heap[largest];
        heap[largest] = temp;
        maxHeapify(largest);
    }
}

public:
    MaxHeap(int max_size) {
        capacity = max_size;
        heap = new int[capacity];
        size = 0;
    }
    ~MaxHeap() {
        delete[] heap;
    }
    void insert(int value) {
        if (size == capacity) {
        cout << "Heap is full. Cannot insert more elements.\n";
        return;
    }
    int index = size;
    heap[index] = value;
    size++;

    while (index > 0 && heap[index] > heap[(index - 1) / 2]) {
      int temp = heap[index];
      heap[index] = heap[(index - 1) / 2];
      heap[(index - 1) / 2] = temp;
      index = (index - 1) / 2;
    }
  }
void printHeap() {
    cout << "Max-Heap: ";
    for (int i = 0; i < size; i++) {
        cout << heap[i] << " ";
    }
    cout << endl;
}
};

int main() {
    BinaryTree tree;
    int nums[] = {10, 20, 15, 7, 9, 30, 25};
    for (int i = 0; i < 7; i++) {
        tree.insert(nums[i]);
    }
    tree.inOrderTraversal();
    tree.preOrderTraversal();
    tree.postOrderTraversal();
    cout << "Enter the number which you want to delete" << endl;
    int deleteNum;
    cin >> deleteNum;
    tree.remove(deleteNum);
    tree.inOrderTraversal();
    tree.preOrderTraversal();
    tree.postOrderTraversal();

    MaxHeap maxHeap(10);
    for (int i = 0; i < 7; i++) {
        maxHeap.insert(nums[i]);
    }
    maxHeap.printHeap();
    return 0;
}
