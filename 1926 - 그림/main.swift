//
//  main.swift
//  1926 - 그림
//

import Foundation

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, m) = (input[0], input[1])

var board: [[Int]] = []
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").compactMap { Int($0) }
    board.append(line)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < m
}

func bfs(_ r: Int, _ c: Int) -> Int {
    var square = 1
    var stack: [(Int, Int)] = [(r, c)]
    board[r][c] = 0

    while !stack.isEmpty {
        let (y, x) = stack.removeFirst()
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            guard check(ny, nx), board[ny][nx] == 1 else { continue }

            square += 1
            board[ny][nx] = 0
            stack.append((ny, nx))
        }
    }
    return square
}

var arts: [Int] = []

for r in 0..<n {
    for c in 0..<m {
        if board[r][c] == 1 {
            arts.append(bfs(r, c))
        }
    }
}

if arts.isEmpty {
    print(0)
    print(0)
} else {
    arts.sort(by: >)
    print(arts.count)
    print(arts[0])
}
