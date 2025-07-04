//
//  main.swift
//  2098 - 외판원 순회
//

import Foundation

let inf = Int(1e9)
let n = Int(readLine()!)!
var cost: [[Int]] = []
for _ in 0..<n {
    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    cost.append(line)
}
var dp = Array(repeating: Array(repeating: inf, count: n), count: 1 << n)
dp[1 << 0][0] = 0 // 0001 은 0번 도시를 방문했다는 뜻

for mask in 0..<(1 << n) {
    for cur in 0..<n {
        guard (mask & (1 << cur)) != 0 else { continue }
        
        for nxt in 0..<n {
            // 갔던 데 또 가면 안되고, 길이 없으면 안됨
            guard (mask & (1 << nxt)) == 0 , cost[cur][nxt] != 0 else { continue }
            
            let nextMask = mask | (1 << nxt)
            dp[nextMask][nxt] = min(dp[nextMask][nxt], dp[mask][cur] + cost[cur][nxt])
        }
    }
}

let fullMask = 1 << n - 1
var answer = inf

for i in 0..<n {
    if cost[i][0] != 0 {
        answer = min(answer, dp[fullMask][i] + cost[i][0])
    }
}

print(answer)
