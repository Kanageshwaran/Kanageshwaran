#include <iostream>
#include <fstream>
#include <string>
#include <cctype>

using namespace std;

struct Node
{
    string name;
    Node *next;
    Node *prev;
};

static inline string rtrim(const string &s)
{
    size_t end = s.find_last_not_of(" \t\r\n");
    return (end == string::npos) ? "" : s.substr(0, end + 1);
}

static inline string ltrim(const string &s)
{
    size_t start = s.find_first_not_of(" \t\r\n");
    return (start == string::npos) ? "" : s.substr(start);
}

static inline string trim(const string &s)
{
    return rtrim(ltrim(s));
}

Node *createNode(const string &name)
{
    Node *n = new Node;
    n->name = name;
    n->next = nullptr;
    n->prev = nullptr;
    return n;
}

// Inserts name in alphabetical order (ascending). Keeps list sorted.
void insertSorted(Node *&head, Node *&tail, const string &name)
{
    Node *newNode = createNode(name);

    // Case 1: empty list
    if (!head)
    {
        head = tail = newNode;
        return;
    }

    // Case 2: insert before head
    if (name <= head->name)
    {
        newNode->next = head;
        head->prev = newNode;
        head = newNode;
        return;
    }

    // Case 3: insert after tail
    if (name >= tail->name)
    {
        tail->next = newNode;
        newNode->prev = tail;
        tail = newNode;
        return;
    }

    // Case 4: insert in middle
    Node *cur = head;
    while (cur && cur->name < name)
    {
        cur = cur->next;
    }
    // cur is the first node with cur->name >= name
    // insert newNode before cur
    Node *before = cur->prev;

    before->next = newNode;
    newNode->prev = before;

    newNode->next = cur;
    cur->prev = newNode;
}

// Deletes the first occurrence of name if found.
void deleteName(Node *&head, Node *&tail, const string &name)
{
    if (!head)
        return;

    Node *cur = head;
    while (cur && cur->name != name)
    {
        cur = cur->next;
    }
    if (!cur)
        return; // not found

    // Update head/tail if needed
    if (cur == head)
        head = cur->next;
    if (cur == tail)
        tail = cur->prev;

    // Relink neighbors
    if (cur->prev)
        cur->prev->next = cur->next;
    if (cur->next)
        cur->next->prev = cur->prev;

    delete cur;
}

void writeOutput(const string &filename, Node *head, Node *tail)
{
    ofstream out(filename);
    if (!out)
    {
        cerr << "Error: could not open " << filename << " for writing.\n";
        exit(1);
    }

    // Forward: head -> tail
    for (Node *cur = head; cur != nullptr; cur = cur->next)
    {
        out << cur->name << "\n";
    }

    out << "=============\n";

    // Backward: tail -> head
    for (Node *cur = tail; cur != nullptr; cur = cur->prev)
    {
        out << cur->name << "\n";
    }
}

void freeList(Node *&head, Node *&tail)
{
    Node *cur = head;
    while (cur)
    {
        Node *next = cur->next;
        delete cur;
        cur = next;
    }
    head = nullptr;
    tail = nullptr;
}

int main()
{
    const string inputFileName = "input.txt";
    const string outputFileName = "output.txt";

    ifstream in(inputFileName);
    if (!in)
    {
        cerr << "Error: could not open " << inputFileName << " for reading.\n";
        return 1;
    }

    Node *head = nullptr;
    Node *tail = nullptr;

    string line;
    while (getline(in, line))
    {
        line = trim(line);
        if (line.empty())
            continue;

        // If line starts with "delete" (case-sensitive per spec)
        const string cmd = "delete";
        if (line.rfind(cmd, 0) == 0)
        {
            // Accept "delete <name>" with optional extra spaces
            string nameToDelete = trim(line.substr(cmd.size()));
            // If line was "deleteBob" (no space), nameToDelete would be "Bob" after trim
            // but typical format is "delete <name>".
            if (!nameToDelete.empty())
            {
                deleteName(head, tail, nameToDelete);
            }
        }
        else
        {
            // Insert name
            insertSorted(head, tail, line);
        }
    }

    in.close();

    writeOutput(outputFileName, head, tail);
    freeList(head, tail);

    return 0;
}
