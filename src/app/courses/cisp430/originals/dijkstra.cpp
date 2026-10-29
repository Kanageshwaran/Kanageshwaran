#include <iostream>
#include <vector>
#include <queue>
#include <limits>
#include <algorithm>
#include <iomanip>

using namespace std;

struct Edge
{
    int to;
    double w;
};

static const double INF = numeric_limits<double>::infinity();

// Reconstruct path from start -> v using predecessor array.
// If unreachable, returns empty vector.
vector<int> build_path(int start, int v, const vector<int> &pred)
{
    vector<int> path;
    if (v == start)
    {
        path.push_back(start);
        return path;
    }
    if (pred[v] == -1)
        return {}; // unreachable

    int cur = v;
    while (cur != -1)
    {
        path.push_back(cur);
        if (cur == start)
            break;
        cur = pred[cur];
    }
    if (path.back() != start)
        return {}; // safety check
    reverse(path.begin(), path.end());
    return path;
}

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    if (!cin || n <= 0 || m < 0)
    {
        cerr << "Invalid input. Expected: n m, with n>0 and m>=0.\n";
        return 1;
    }

    // Toggle: set true for undirected graph, false for directed graph.
    const bool UNDIRECTED = true;

    vector<vector<Edge>> graph(n);
    bool has_negative = false;

    for (int i = 0; i < m; i++)
    {
        int u, v;
        double w;
        cin >> u >> v >> w;

        if (!cin)
        {
            cerr << "Invalid edge input at line " << (i + 1) << ".\n";
            return 1;
        }
        if (u < 0 || u >= n || v < 0 || v >= n)
        {
            cerr << "Edge uses out-of-range vertex index: " << u << " " << v << "\n";
            return 1;
        }
        if (w < 0)
            has_negative = true;

        graph[u].push_back({v, w});
        if (UNDIRECTED)
        {
            graph[v].push_back({u, w});
        }
    }

    int start;
    cin >> start;
    if (!cin || start < 0 || start >= n)
    {
        cerr << "Invalid start vertex.\n";
        return 1;
    }

    if (has_negative)
    {
        cerr << "Error: Graph contains a negative edge weight. Dijkstra's algorithm requires non-negative weights.\n";
        return 1;
    }

    // Dijkstra: distances + predecessors
    vector<double> dist(n, INF);
    vector<int> pred(n, -1);
    vector<bool> visited(n, false);

    // Min-heap of (distance, vertex)
    priority_queue<pair<double, int>, vector<pair<double, int>>, greater<pair<double, int>>> pq;

    dist[start] = 0.0;
    pq.push({0.0, start});

    while (!pq.empty())
    {
        auto [d, u] = pq.top();
        pq.pop();

        if (visited[u])
            continue;
        visited[u] = true;

        // Relax outgoing edges
        for (const auto &e : graph[u])
        {
            int v = e.to;
            double nd = d + e.w;
            if (!visited[v] && nd < dist[v])
            {
                dist[v] = nd;
                pred[v] = u;
                pq.push({nd, v});
            }
        }
    }

    cout << fixed << setprecision(2);
    cout << "Start vertex: " << start << "\n\n";

    for (int v = 0; v < n; v++)
    {
        cout << "Vertex " << v << ": ";

        if (dist[v] == INF)
        {
            cout << "unreachable\n";
            continue;
        }

        cout << "dist = " << dist[v] << " | path = ";

        vector<int> path = build_path(start, v, pred);
        if (path.empty())
        {
            // Should not happen when dist[v] != INF, but keep safe
            cout << "(path not found)\n";
            continue;
        }

        for (size_t i = 0; i < path.size(); i++)
        {
            cout << path[i];
            if (i + 1 < path.size())
                cout << " -> ";
        }
        cout << "\n";
    }

    return 0;
}