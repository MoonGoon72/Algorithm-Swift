//
//  main.swift
//  이코테 - boj - 18405 - 경쟁적 전염
//

import Foundation

let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

var input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0], k = input[1]
var graph = [[Int]]()
var virus = [(Int, Int, Int)]()
var virusIdx = 0
var virusLast = 0
for i in 0..<n {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    for j in 0..<n {
        if line[j] != 0 {
            virus.append((line[j], i, j))
            virusLast += 1
        }
    }
    graph.append(line)
}
virus.sort { $0.0 < $1.0 }
input = readLine()!.split(separator: " ").map { Int($0)! }
let s = input[0], rx = input[1] - 1, ry = input[2] - 1

func check(_ x: Int, _ y: Int) -> Bool {
    0 <= x && x < n && 0 <= y && y < n
}

for _ in 0..<s {
    let last = virusLast
    while virusIdx < last {
        let (v, x, y) = virus[virusIdx]
        virusIdx += 1
        
        for i in 0..<4 {
            let (nx, ny) = (x + dx[i], y + dy[i])
            guard check(nx, ny) && graph[nx][ny] == 0 else { continue }
            
            graph[nx][ny] = v
            virus.append((v, nx, ny))
            virusLast += 1
        }
    }
}

print(graph[rx][ry])
