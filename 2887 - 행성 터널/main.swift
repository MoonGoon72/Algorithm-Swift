//
//  main.swift
//  2887 - 행성 터널
//

import Foundation

func union(_ parents: inout [Int], _ x: Int, _ y: Int) {
    let (px, py) = (find(&parents, x), find(&parents, y))
    if px < py {
        parents[py] = px
    } else {
        parents[px] = py
    }
}

func find(_ parents: inout [Int], _ x: Int) -> Int {
    if parents[x] != x {
        parents[x] = find(&parents, parents[x])
    }
    return parents[x]
}

let n = Int(readLine()!)!
var parents = Array<Int>()

for i in 0..<n {
    parents.append(i)
}

var x = Array<(Int, Int)>()
var y = Array<(Int, Int)>()
var z = Array<(Int, Int)>()

for i in 0..<n {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    x.append((input[0], i))
    y.append((input[1], i))
    z.append((input[2], i))
}

x.sort(by: <)
y.sort(by: <)
z.sort(by: <)

var edges = Array<(Int, Int, Int)>()

for i in 0..<(n - 1) {
    edges.append((x[i + 1].0 - x[i].0, x[i].1, x[i + 1].1))
    edges.append((y[i + 1].0 - y[i].0, y[i].1, y[i + 1].1))
    edges.append((z[i + 1].0 - z[i].0, z[i].1, z[i + 1].1))
}
edges.sort(by: <)

var answer = 0
for edge in edges {
    let (cost, i, j) = edge
    if find(&parents, i) != find(&parents, j) {
        union(&parents, i, j)
        answer += cost
    }
}

print(answer)
