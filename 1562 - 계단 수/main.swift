//
//  main.swift
//  1562 - 계단 수
//

import Foundation

let mod = 1_000_000_000
let n = Int(readLine()!)!
var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: 1 << 10), count: 10), count: n + 1)

if n < 10 {
    print(0)
    exit(0)
}

for i in 1..<10 {
    dp[1][i][1 << i] = 1
}

for i in 1..<n {
    for j in 0..<10 {
        for mask in 0..<(1 << 10) {
            guard dp[i][j][mask] != 0 else { continue }
            
            if j > 0 {
                let next = j - 1
                let nextMask = mask | (1 << next)
                dp[i + 1][next][nextMask] = (dp[i + 1][next][nextMask] + dp[i][j][mask]) % mod
            }
            
            if j < 9 {
                let next = j + 1
                let nextMask = mask | (1 << next)
                dp[i + 1][next][nextMask] = (dp[i + 1][next][nextMask] + dp[i][j][mask]) % mod
            }
        }
    }
}

let fullMask = (1 << 10) - 1
var answer = 0
for i in 0..<10 {
    answer = (answer + dp[n][i][fullMask]) % mod
}
print(answer)
