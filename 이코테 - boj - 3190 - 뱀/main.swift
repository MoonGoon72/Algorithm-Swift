//
//  main.swift
//  이코테 - boj - 3190 - 뱀
//

import Foundation

let direction = [Position(y: 0, x: 1), Position(y: 1, x: 0), Position(y: 0, x: -1), Position(y: -1, x: 0)]
let n = Int(readLine()!)!
let k = Int(readLine()!)!
var apples: [Position] = []
var usedApples: [Position] = []

for _ in 0..<k {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    apples.append(Position(y: input[0], x: input[1]))
}

let l = Int(readLine()!)!
var directionChangeInfo = Array<(Int, String)>()
for _ in 0..<l {
    let input = readLine()!.components(separatedBy:
    " ")
    directionChangeInfo.append((Int(input[0])!, input[1]))
}
var idx = 0 // 방향 전환 정보를 remove 하지 않고 idx를 옮겨서 확인
var time = 0
var d = 0
var queue = [Position(y: 1, x: 1)]

while true {
    time += 1
    let pos = queue.last!
    let (ny, nx) = (pos.y + direction[d].y, pos.x + direction[d].x)
    let newPos = Position(y: ny, x: nx)
    guard (1...n).contains(ny) &&
            (1...n).contains(nx) &&
            !queue.contains(newPos)
    else {
        print(time)
        break
    }
    
    // 방향 전환
    if idx < directionChangeInfo.count &&
        directionChangeInfo[idx].0 == time {
        switch directionChangeInfo[idx].1 {
        case "D":
            d = (d + 1) % 4
        case "L":
            d = d == 0 ? 3 : (d - 1) % 4
        default:
            break
        }
        idx += 1
    }
    
    queue.append(newPos)
    if apples.contains(newPos) && !usedApples.contains(newPos) {
        usedApples.append(newPos)
    } else {
        queue.removeFirst()
    }
}

struct Position: Equatable {
    let y: Int
    let x: Int
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.y == rhs.y && lhs.x == rhs.x
    }
}
