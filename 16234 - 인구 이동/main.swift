//
//  main.swift
//  16234 - 인구 이동
//

import Foundation

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, l, r) = (input[0], input[1], input[2])

var board:[[Int]] = []

for _ in 0..<n {
    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    board.append(line)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < n
}

func bfs(_ y: Int, _ x: Int, _ visited: inout [[Bool]]) -> Bool {
    var queue: [(Int, Int)] = [(y, x)]
    var federation: [(Int, Int)] = [(y, x)]
    visited[y][x] = true
    
    while !queue.isEmpty {
        let (y, x) = queue.removeFirst()
        
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            
            guard check(ny, nx) && !visited[ny][nx] else { continue }
            
            let diff = abs(board[y][x] - board[ny][nx])
            if l <= diff && diff <= r {
                federation.append((ny, nx))
                visited[ny][nx] = true
                queue.append((ny, nx))
            }
        }
    }
    guard federation.count > 1 else { return false }
    
    let total = Int(federation.reduce(0) { $0 + board[$1.0][$1.1] } / federation.count)
    federation.forEach { board[$0.0][$0.1] = total }
    return true
}

var count = 0

while true {
    var visited = Array(repeating: Array(repeating: false, count: n), count: n)
    var moved = false
    for row in 0..<n {
        for col in 0..<n {
            guard !visited[row][col] else { continue }
            
            if bfs(row, col, &visited) {
                moved = true
            }
        }
    }
    if moved {
        count += 1
    } else {
        break
    }
}

print(count)
