//
//  main.swift
//  14499 - 주사위 굴리기
//

import Foundation

typealias Pos = (x: Int, y: Int)
let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, m, k) = (input[0], input[1], input[4])
var x = input[2]
var y = input[3]

var board: [[Int]] = []
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").compactMap { Int($0) }
    board.append(line)
}

let orders = readLine()!.split(separator: " ").map { Int($0)! - 1 }
// 주사위를 굴릴 때 어떻게 돌아가는 지 기록
// 굴렸을 때 해당 칸의 수를 확인하여 주사위에 기록할 지, 보드에 기록할 지 정하기
var dice = Array(repeating: Array(repeating: 0, count: 3), count: 4)
let floor: Pos = (3, 1)
let top: Pos = (1, 1)
let east: Pos = (1, 2)
let west: Pos = (1, 0)
let north: Pos = (2, 1)
let south: Pos = (0, 1)

func roll(_ d: Int) {
    let f = dice[floor.x][floor.y]
    let t = dice[top.x][top.y]
    let e = dice[east.x][east.y]
    let w = dice[west.x][west.y]
    let n = dice[north.x][north.y]
    let s = dice[south.x][south.y]

    switch d {
    case 0: // 동쪽으로 굴림
        // floor -> west, west -> top, top -> east, east -> floor
        dice[west.x][west.y] = f
        dice[top.x][top.y] = w
        dice[east.x][east.y] = t
        dice[floor.x][floor.y] = e
    case 1: // 서쪽으로 굴림
        // floor -> east, east -> top, top -> west, west -> floor
        dice[east.x][east.y] = f
        dice[top.x][top.y] = e
        dice[west.x][west.y] = t
        dice[floor.x][floor.y] = w
    case 2: // 북쪽으로 굴림
        // floor -> south, south -> top, top -> north, north -> floor
        dice[south.x][south.y] = f
        dice[top.x][top.y] = s
        dice[north.x][north.y] = t
        dice[floor.x][floor.y] = n
    case 3: // 남쪽으로 굴림
        // floor -> north, north -> top, top -> south, south -> floor
        dice[north.x][north.y] = f
        dice[top.x][top.y] = n
        dice[south.x][south.y] = t
        dice[floor.x][floor.y] = s
    default:
        return
    }
}

func check(_ x: Int, _ y: Int) -> Bool {
    return 0 <= x && x < n && 0 <= y && y < m
}

for order in orders {
    let (nx, ny) = (x + dx[order], y + dy[order])
    guard check(nx, ny) else { continue }

    (x, y) = (nx, ny)
    roll(order)
    // 바닥면 확인
    if board[x][y] != 0 {
        dice[floor.x][floor.y] = board[x][y]
        board[x][y] = 0
    } else {
        board[x][y] = dice[floor.x][floor.y]
    }
    // 상단 출력
    print(dice[top.x][top.y])
}
