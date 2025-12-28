//
//  main.swift
//  12865 - 평범한 배낭
//

import Foundation

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, k) = (input[0], input[1])
var object: [(Int, Int)] = []
var dp = Array(repeating: Array(repeating: 0, count: k + 1), count: n)
for _ in 0..<n {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (w, v) = (input[0], input[1])
    object.append((w, v))
}

for w in 0..<k + 1 {
    if w >= object[0].0 {
        dp[0][w] = object[0].1
    }
}

for i in 1..<n {
    let (weight, value) = object[i]
    for w in 1..<k + 1 {
        if w < weight {
            dp[i][w] = dp[i - 1][w]
        } else {
            dp[i][w] = max(dp[i - 1][w], value + dp[i - 1][w - weight])
        }
    }
}

print(dp[n - 1].sorted(by: >).first!)
