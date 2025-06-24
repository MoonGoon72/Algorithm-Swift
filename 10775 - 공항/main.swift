//
//  main.swift
//  10775 - 공항
//

import Foundation

let g = Int(readLine()!)!
let p = Int(readLine()!)!
var planes: [Int] = []
var parents: [Int] = []

for _ in 0..<p {
    planes.append(Int(readLine()!)!)
}

for i in 0...g {
    parents.append(i)
}

func union(_ x: Int, _ y: Int) {
    let (px, py) = (find(x), find(y))
    guard px != py else { return }
    
    if px < py {
        parents[py] = px
    } else {
        parents[px] = py
    }
}

func find(_ x: Int) -> Int {
    if parents[x] != x {
        parents[x] = find(parents[x])
    }
    return parents[x]
}

var count = 0
for p in planes {
    let px = find(p)
    guard px != 0 else { break }
    
    union(px, px - 1)
    count += 1
}

print(count)
