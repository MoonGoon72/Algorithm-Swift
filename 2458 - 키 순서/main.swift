//
//  main.swift
//  2458 - 키 순서
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
let inf = Int(1e9)

func floidSolution() -> Int {
    var graph = Array(repeating: Array(repeating: inf, count: n + 1), count: n + 1)
    
    for _ in 0..<m {
        let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
        let (a, b) = (input[0], input[1])
        graph[a][b] = 1
    }
    
    for i in 1...n { graph[i][i] = 1 }
    
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                graph[i][j] = min(graph[i][j], graph[i][k] + graph[k][j])
            }
        }
    }
    
    var result = 0
    
    for i in 1...n {
        var count = 0
        for j in 1...n {
            if graph[i][j] < inf || graph[j][i] < inf {
                count += 1
            }
        }
        if count == n {
            result += 1
        }
    }
    return result
}

func bfsSolution() -> Int {
    var graph = Array(repeating: Array<Int>(), count: n + 1)
    var reverseGraph = Array(repeating: Array<Int>(), count: n + 1)
    
    for _ in 0..<m {
        let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
        let (a, b) = (input[0], input[1])
        graph[a].append(b)
        reverseGraph[b].append(a)
    }
    
    var result = 0
    for i in 1...n {
        let higher = bfs(start: i, graph: graph)
        let lower = bfs(start: i, graph: reverseGraph)
        if higher + lower == n - 1 {
            result += 1
        }
    }
    
    return result
}

func bfs(start: Int, graph: [[Int]]) -> Int {
    var queue: [Int] = []
    var visited: [Bool] = Array(repeating: false, count: n + 1)
    visited[start] = true
    queue.append(start)
    var count = 0
    
    while !queue.isEmpty {
        let now = queue.removeFirst()
        for node in graph[now] {
            if !visited[node] {
                queue.append(node)
                visited[node] = true
                count += 1
            }
        }
    }
    
    return count
}

//print(floidSolution())
print(bfsSolution())
