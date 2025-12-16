//
//  main.swift
//  14891 - 톱니바퀴
//

import Foundation

let gear1 = readLine()!.compactMap { Int(String($0)) }
let gear2 = readLine()!.compactMap { Int(String($0)) }
let gear3 = readLine()!.compactMap { Int(String($0)) }
let gear4 = readLine()!.compactMap { Int(String($0)) }
var gears = [gear1, gear2, gear3, gear4]
let k = Int(readLine()!)!

for _ in 0..<k {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (gear, direction) = (input[0] - 1, input[1])
    // 톱니들 회전 방향 정하기
    // 회전 명령을 받은 기어를 기준으로 어디까지 도나 확인을 어디서 할까?
    var queue: [(Int, Int)] = [(gear, direction)]
    var idx = 0
    var isRotated = Array(repeating: false, count: 4)
    isRotated[gear] = true

    while idx < queue.count {
        let (now, d) = queue[idx]
        idx += 1

        if now == 0 {
            if gears[now][2] != gears[now + 1][6] && !isRotated[now + 1] {
                queue.append((now + 1, -d))
                isRotated[now + 1] = true
            }
        } else if now == 3 {
            if gears[now][6] != gears[now - 1][2] && !isRotated[now - 1] {
                queue.append((now - 1, -d))
                isRotated[now - 1] = true
            }
        } else {
            if gears[now][6] != gears[now - 1][2] && !isRotated[now - 1] {
                queue.append((now - 1, -d))
                isRotated[now - 1] = true
            }
            if gears[now][2] != gears[now + 1][6] && !isRotated[now + 1] {
                queue.append((now + 1, -d))
                isRotated[now + 1] = true
            }
        }
        rotate(now, d, &gears)
    }
}

// 톱니바퀴 점수 합 계산
print(calculate(gears))

func rotate(_ gear: Int, _ direction: Int, _ gears: inout [[Int]]) {
    let doubleArr = gears[gear] + gears[gear]
    if direction == 1 {
        gears[gear] = Array(doubleArr[7..<7+8])
    } else {
        gears[gear] = Array(doubleArr[1..<1+8])
    }
}

func calculate(_ gears: [[Int]]) -> Int {
    var count = 0

    for gear in 0..<4 {
        if gears[gear][0] == 1 {
            count += Int(pow(2.0, Double(gear)))
        }
    }
    return count
}
