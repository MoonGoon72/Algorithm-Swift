//
//  main.swift
//  14501 - 퇴사
//

import Foundation

let n = Int(readLine()!)!
var t: [Int] = []
var p: [Int] = []
var dp = Array(repeating: 0, count: n + 1)
var maxValue = 0

for _ in 0..<n {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    t.append(input[0])
    p.append(input[1])
}

for i in (0..<n).reversed() {
    let time = t[i] + i
    guard time <= n else {
        dp[i] = maxValue
        continue
    }
    
    dp[i] = max(p[i] + dp[time], maxValue)
    maxValue = dp[i]
}

print(maxValue)
