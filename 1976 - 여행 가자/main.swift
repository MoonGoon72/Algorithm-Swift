//
//  main.swift
//  1976 - 여행 가자
//

import Foundation

func union(_ x: Int, _ y: Int) {
    let (px, py) = (find(x), find(y))
    
    guard px != py else { return }
    
    if px < py {
        parent[py] = px
    } else {
        parent[px] = py
    }
}

@discardableResult
func find(_ x: Int) -> Int {
    if parent[x] != x {
        parent[x] = find(parent[x])
    }
    return parent[x]
}

let n = Int(readLine()!)!
let m = Int(readLine()!)!

var parent: [Int] = []
for i in 0...n {
    parent.append(i)
}

for i in 1...n {
    let path = [0] + readLine()!.components(separatedBy: " ").map { Int($0)! }
    for j in 1...n {
        if path[j] == 1 {
            union(i, j)
        }
    }
}

for i in 1...n {
    find(i)
}

let path = readLine()!.components(separatedBy: " ").map { Int($0)! }
let result = find(path[0])
var answer = true
for p in path {
    if find(p) != result {
        answer = false
    }
}

print(answer ? "YES" : "NO")
