//
//  main.swift
//  1260
//
//  Created by MoonGoon on 6/22/24.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let m = input[1]
let v = input[2]

var graph: [[Int]] = Array(repeating: [], count: n+1)
var visited: [Bool] = Array(repeating: false, count: n+1)

for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map { Int($0)!}
    let a = line[0]
    let b = line[1]
    graph[a].append(b)
    graph[b].append(a)
}

func dfs(start: Int) {
    var stack: [Int] = [start]
    var array: [String] = []
    var result = ""
    while !stack.isEmpty {
        let now = stack.removeLast()
        if !visited[now] {
            array.append(String(now))
            visited[now] = true
            graph[now].sort(by: >)
            for num in graph[now] {
                if !visited[num] {
                    stack.append(num)
                }
            }
        }
    }
    result = array.joined(separator: " ")
    print(result)
}

func bfs(start: Int) {
    var queue: [Int] = [start]
    var array: [String] = []
    var result = ""
    while !queue.isEmpty {
        let now = queue.removeFirst()
        array.append(String(now))
        visited[now] = true
        graph[now].sort()
        for num in graph[now] {
            if !visited[num] {
                queue.append(num)
                visited[num] = true
            }
        }
    }
    result = array.joined(separator: " ")
    print(result)
}

dfs(start: v)
visited = Array(repeating: false, count: n+1)
bfs(start: v)
