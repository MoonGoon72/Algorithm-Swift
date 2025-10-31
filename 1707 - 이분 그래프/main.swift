//
//  main.swift
//  1707 - 이분 그래프
//

import Foundation

func union(_ x: Int, _ y: Int, _ parent: inout [Int]) {
    let (px, py) = (find(x, &parent), find(y, &parent))
    
    if px > py {
        parent[px] = py
    } else {
        parent[py] = px
    }
}

func find(_ x: Int, _ parent: inout [Int]) -> Int {
    if parent[x] != x {
        parent[x] = find(parent[x], &parent)
    }
    
    return parent[x]
}

func bfs(_ v: Int, _ graph: [[Int]], _ visited: [Int]) -> Bool {
    var visited = visited
    visited[v] = 1
    var queue = [v]
    var idx = 0
    
    while idx < queue.count {
        let v = queue[idx]
        idx += 1
        
        for node in graph[v] {
            if visited[node] == 0 {
                visited[node] = visited[v] * -1
                queue.append(node)
            } else {
                if visited[node] == visited[v] {
                    return false
                }
            }
        }
    }

    return true
}

let k = Int(readLine()!)!

for _ in 0..<k {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (v, e) = (input[0], input[1])
    var graph = Array(repeating: Array<Int>(), count: v + 1)
    let visited = Array(repeating: 0, count: v + 1)
    var parent = Array(Range(0...v))
    
    for _ in 0..<e {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (input[0], input[1])
        graph[a].append(b)
        graph[b].append(a)
        union(a, b, &parent)
    }
    
    var nodes = Array(repeating: [Int](), count: v + 1)
    for node in 1...v {
        let p = find(node, &parent)
        nodes[p].append(node)
    }
    
    var flag = true
    for arr in nodes {
        if let node = arr.first {
            flag = bfs(node, graph, visited)
        }
        if !flag { break }
    }
    print(flag ? "YES" : "NO")
}
