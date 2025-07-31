//
//  main.swift
//  이코테 - boj - 15686 - 치킨 배달
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var graph = Array<[Int]>()
var chickens = Array<(Int, Int)>()
var houses = Array<(Int, Int)>()
for i in 0..<n {
    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    for j in 0..<n {
        if line[j] == 1 {
            houses.append((i, j))
        } else if line[j] == 2 {
            chickens.append((i, j))
        }
    }
    graph.append(line)
}

func combination<T>(_ array: [T], count: Int) -> [[T]] {
    if count == 0 {
        return [[]]
    }
    guard let first = array.first else {
        return []
    }
    
    let head = [first]
    let subCombination = combination(Array(array.dropFirst()), count: count - 1).map { head + $0 }
    return subCombination + combination(Array(array.dropFirst()), count: count)
}

func chickenDistance(_ pos1: (Int, Int), _ pos2: (Int, Int)) -> Int {
    abs(pos1.0 - pos2.0) + abs(pos1.1 - pos2.1)
}

var answer = Int(1e9)
for comb in combination(chickens, count: m) {
    var tmp = 0
    for house in houses {
        var minimum = 2500
        comb.forEach { chicken in
            minimum = min(minimum, chickenDistance(house, chicken))
        }
        tmp += minimum
    }
    answer = min(answer, tmp)
}

print(answer)
