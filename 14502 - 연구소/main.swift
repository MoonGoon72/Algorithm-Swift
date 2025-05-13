//
//  main.swift
//  14502 - 연구소
//
//  Created by 문영균 on 5/13/25.
//

import Foundation

let dy = [-1 ,1 ,0 ,0]
let dx = [0, 0, -1, 1]

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var graph: [[Int]] = []
var virus: [(Int, Int)] = []
var spaces: [(Int, Int)] = []

for i in 0..<n {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    for j in 0..<m {
        if line[j] == 2 {
            virus.append((i, j))
        } else if line[j] == 0 {
            spaces.append((i, j))
        }
    }
    graph.append(line)
}

func combinations<T>(_ array: [T], count: Int) -> [[T]] {
    if count == 0 { return [[]] }
    
    guard let first = array.first else { return [] }
    let head = [first]
    let subcombs = combinations(Array(array.dropFirst()), count: count - 1).map { head + $0 }
    return subcombs + combinations(Array(array.dropFirst()), count: count)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < m
}

func simulate(_ walls: [(Int, Int)]) -> Int {
    var tmp = graph
    for (y, x) in walls {
        tmp[y][x] = 2
    }
    
    var queue = virus
    while !queue.isEmpty {
        let (y, x) = queue.removeFirst()
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            if check(ny, nx) && tmp[ny][nx] == 0 {
                tmp[ny][nx] = 2
                queue.append((ny, nx))
            }
        }
    }
    let count = tmp.reduce(0){ $0 + $1.filter { $0 == 0 }.count }
    return count
}

var result = 0
let wallCombinations = combinations(spaces, count: 3)

for wallCombination in wallCombinations {
    result = max(result, simulate(wallCombination))
}
print(result)
