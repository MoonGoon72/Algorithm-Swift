//
//  main.swift
//  17143 - 낚시왕
//

import Foundation

struct Pos: Hashable {
    let r: Int
    let c: Int

    static func ==(lhs: Pos, rhs: Pos) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c
    }
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, 1, -1]

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (r, c, m) = (input[0], input[1], input[2])

let empty: (r: Int, c: Int, s: Int, d: Int, z: Int) = (0, 0, 0, 0, 0)
var board = Array(repeating: Array(repeating: -1, count: c + 1), count: r + 1)
var sharks = Array(repeating: empty, count: m)

for i in 0..<m {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    // r = 행, c = 열, s = 속력, d = 이동 방향, z = 크기
    sharks[i] = (input[0], input[1], input[2], input[3] - 1, input[4])
    board[input[0]][input[1]] = i
}

func pick(_ column: Int) -> Int {
    for row in 1...r {
        let shark = board[row][column]
        if shark != -1 {
            let size = sharks[shark].4
            sharks[shark] = empty
            board[row][column] = -1
            return size
        }
    }
    return 0
}

func move() {
    var position: [Pos: [Int]] = [:]

    for shark in 0..<m {
        var (row, col, s, d, z) = sharks[shark]
        guard (row, col, s, d, z) != empty else { continue }

        let cycle = (d == 0 || d == 1) ? 2 * (r - 1) : 2 * (c - 1)
        let moveCount = s % cycle

        for _ in 0..<moveCount {
            if row == 1 && d == 0 {
                d = 1
            } else if row == r && d == 1 {
                d = 0
            } else if col == c && d == 2 {
                d = 3
            } else if col == 1 && d == 3 {
                d = 2
            }
            row += dy[d]
            col += dx[d]
        }
        sharks[shark].d = d
        position[Pos(r: row, c: col), default: []].append(shark)
    }
    // 상어 위치 갱신
    position.keys.forEach { pos in
        let arr = position[pos, default: []].sorted { sharks[$0].4 > sharks[$1].4 }
        let biggestShark = arr[0]
        if board[sharks[biggestShark].0][sharks[biggestShark].1] == biggestShark {
            board[sharks[biggestShark].0][sharks[biggestShark].1] = -1
        }
        sharks[biggestShark].r = pos.r
        sharks[biggestShark].c = pos.c
        board[pos.r][pos.c] = biggestShark

        for i in 1..<arr.count {
            let shark = sharks[arr[i]]
            if board[shark.0][shark.1] == arr[i] {
                board[shark.0][shark.1] = -1
            }
            sharks[arr[i]] = empty
        }
    }
}

var human = 0
var answer = 0

while human < c {
    // human move & pick
    human += 1
    answer += pick(human)
    // shark move
    move()
}

print(answer)
