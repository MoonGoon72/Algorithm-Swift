//
//  main.swift
//  2638 - 치즈
//

import Foundation

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var board = Array<Array<Int>>()
var cheeses: [(Int, Int)] = []

for i in 0..<n {
    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    for j in 0..<m {
        if line[j] == 1 {
            cheeses.append((i, j))
        }
    }
    board.append(line)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < m
}

func makeOutsideAir() -> [[Bool]] {
    var outside = Array(repeating: Array(repeating: false, count: m), count: n)
    var q = [(Int, Int)]()
    var head = 0
    q.append((0, 0))
    outside[0][0] = true
    
    while head < q.count {
        let (y, x) = q[head]
        head += 1
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            if check(ny, nx), !outside[ny][nx], board[ny][nx] == 0 {
                outside[ny][nx] = true
                q.append((ny, nx))
            }
        }
    }
    return outside
}

func willMelt(_ y: Int, _ x: Int, _ outside: [[Bool]]) -> Bool {
    var attached = 0
    for i in 0..<4 {
        let (ny, nx) = (y + dy[i], x + dx[i])
        if check(ny, nx) && outside[ny][nx] {
            attached += 1
        }
    }
    return attached > 1
}

var count = 0

while !cheeses.isEmpty {
    let outside = makeOutsideAir()
    var melts = [(Int, Int)]()
    var tmp = [(Int, Int)]()
    for i in 0..<cheeses.count {
        let (y, x) = cheeses[i]
        if willMelt(y, x, outside) {
            melts.append((y, x))
        } else {
            tmp.append((y, x))
        }
    }
    
    if melts.isEmpty { break }
    
    for (y, x) in melts {
        board[y][x] = 0
    }
    
    cheeses = tmp
    count += 1
}

print(count)
