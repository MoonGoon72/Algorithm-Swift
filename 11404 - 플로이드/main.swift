//
//  main.swift
//  11404 - 플로이드
//

import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var distance = Array(repeating: Array(repeating: Int(1e9), count: n + 1), count: n + 1)

for i in 1...n {
    distance[i][i] = 0
}

for _ in 0..<m {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    let (a, b, c) = (input[0], input[1], input[2])
    distance[a][b] = min(distance[a][b], c)
}

for k in 1...n {
    for i in 1...n {
        for j in 1...n {
            distance[i][j] = min(distance[i][j], distance[i][k] + distance[k][j])
        }
    }
}

for i in 1...n {
    for j in 1...n {
        print(distance[i][j] < Int(1e9) ? distance[i][j] : 0, terminator: " ")
    }
    print()
}
