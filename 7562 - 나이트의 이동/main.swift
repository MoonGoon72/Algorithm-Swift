//
//  main.swift
//  7562 - 나이트의 이동
//

import Foundation

let t = Int(readLine()!)!

func check(_ y: Int, _ x: Int, _ l: Int) -> Bool {
    return 0 <= y && y < l && 0 <= x && x < l
}

func move(_ pos: (y: Int, x: Int), _ to: (y: Int, x: Int)) -> [(Int, Int)] {
    var arr: [(Int, Int)] = []
    let oneD = [(pos.y - 1, pos.x + 2), (pos.y - 2, pos.x + 1)]
    let twoD = [(pos.y - 1, pos.x - 2), (pos.y - 2, pos.x - 1)]
    let threeD = [(pos.y + 1, pos.x - 2), (pos.y + 2, pos.x - 1)]
    let fourD = [(pos.y + 1, pos.x + 2), (pos.y + 2, pos.x + 1)]

//    if to.y < pos.y && to.x > pos.x {           // 1사분면
//        oneD.forEach { arr.append($0) }
//    } else if to.y < pos.y && to.x < pos.x {    // 2사분면
//        twoD.forEach { arr.append($0) }
//    } else if to.y > pos.y && to.x < pos.x {    // 3사분면
//        threeD.forEach { arr.append($0) }
//    } else if to.y > pos.y && to.x > pos.x {    // 4사분면
//        fourD.forEach { arr.append($0) }
//    } else if to.y == pos.y {                   // 같은 y 좌표
//        if to.x > pos.x { // 1 or 4사분면 아무거나
//            oneD.forEach { arr.append($0) }
//            fourD.forEach { arr.append($0) }
//        } else {          // 2 or 3사분면 아무거나
//            twoD.forEach { arr.append($0) }
//            threeD.forEach { arr.append($0) }
//        }
//    } else if to.x == pos.x {                   // 같은 x 좌표
//        if to.y > pos.y {   // 3 or 4사분면
//            threeD.forEach { arr.append($0) }
//            fourD.forEach { arr.append($0) }
//        } else {            // 1 or 2사분면
//            oneD.forEach { arr.append($0) }
//            twoD.forEach { arr.append($0) }
//        }
//    }
    oneD.forEach { arr.append($0) }
    twoD.forEach { arr.append($0) }
    threeD.forEach { arr.append($0) }
    fourD.forEach { arr.append($0) }
    return arr
}

for _ in 0..<t {
    let l = Int(readLine()!)!
    var visited = Array(repeating: Array(repeating: false, count: l), count: l)
    var input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (r, c) = (input[0], input[1])
    visited[r][c] = true

    input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (tr, tc) = (input[0], input[1])
    var queue: [(y: Int, x: Int, cost: Int)] = []
    queue.append((r, c, 0))
    var idx = 0
    var answer = Int(1e9)

    while idx < queue.count {
        let (nr, nc, cost) = queue[idx]
        idx += 1

        guard (nr, nc) != (tr, tc) else {
            answer = cost
            break
        }

        for nxt in move((nr, nc), (tr, tc)) {
            if check(nxt.0, nxt.1, l) && !visited[nxt.0][nxt.1] {
                queue.append((nxt.0, nxt.1, cost + 1))
                visited[nxt.0][nxt.1] = true
            }
        }
    }
    print(answer)
}
