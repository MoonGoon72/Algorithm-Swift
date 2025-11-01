//
//  main.swift
//  1922 - 네트워크 연결
//

import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!

var edges: [(Int, Int, Int)] = []

for _ in 0..<m {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (a, b, c) = (input[0], input[1], input[2])
    edges.append((c, a, b))
}

edges.sort(by: <)

func union(_ x: Int, _ y: Int) {
    let (px, py) = (find(x), find(y))
    
    if px > py {
        parent[px] = py
    } else {
        parent[py] = px
    }
}

func find(_ x: Int) -> Int {
    if parent[x] != x {
        parent[x] = find(parent[x])
    }
    return parent[x]
}

var parent = Array(Range(0...n))
var answer = 0
var count = 0

for edge in edges {
    if count == n - 1 {
        break
    }
    
    let (cost, a, b) = edge
    guard find(a) != find(b) else { continue }
    
    union(a, b)
    answer += cost
    count += 1
}
print(answer)
