//
//  main.swift
//  1520 - 내리막 길
//

import Foundation

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (m, n) = (input[0], input[1])

var board: [[Int]] = []
for _ in 0..<m {
    let line = readLine()!.split(separator: " ").compactMap { Int($0) }
    board.append(line)
}
var dp = Array(repeating: Array(repeating: -1, count: n), count: m)

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < m && 0 <= x && x < n
}

func dfs(_ y: Int, _ x: Int) -> Int {
    if (y, x) == (m - 1, n - 1) { return 1 }
    guard dp[y][x] == -1 else { return dp[y][x] }
    
    dp[y][x] = 0
    
    for d in 0..<4 {
        let (ny, nx) = (y + dy[d], x + dx[d])
        guard check(ny, nx) && board[ny][nx] < board[y][x] else { continue }
        
        dp[y][x] += dfs(ny, nx)
    }
    return dp[y][x]
}

let answer = dfs(0, 0)
print(answer)
