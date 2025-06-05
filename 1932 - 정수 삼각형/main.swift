//
//  main.swift
//  1932 - 정수 삼각형
//

import Foundation

let n = Int(readLine()!)!
var dp: [[Int]] = []

for _ in 0..<n {
    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    dp.append(line)
}

for i in 1..<n {
    for j in 0..<i + 1 {
        var leftUp = 0
        var up = 0
        if j != 0 {
            leftUp = dp[i - 1][j - 1]
        }
        if j != i {
            up = dp[i - 1][j]
        }
        dp[i][j] += max(leftUp, up)
    }
}

let answer = dp[n - 1].sorted(by: >)[0]
print(answer)
