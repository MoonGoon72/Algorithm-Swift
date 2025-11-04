//
//  main.swift
//  11403 - 경로 찾기
//

import Foundation

let n = Int(readLine()!)!
var graph: [[Int]] = []
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").compactMap { Int($0) }
    graph.append(line)
}


for k in 0..<n {
    for i in 0..<n {
        for j in 0..<n {
            if graph[i][j] == 0 {
                if graph[i][k] != 0 && graph[k][j] != 0 {
                    graph[i][j] = 1
                }
            }
        }
    }
}

for i in 0..<n {
    print(graph[i].map { String($0) }.joined(separator: " "))
}
