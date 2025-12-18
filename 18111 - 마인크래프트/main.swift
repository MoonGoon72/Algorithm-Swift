//
//  main.swift
//  18111 - 마인크래프트
//

import Foundation

// 땅파기 2초, 쌓기 1초 -> 두개 쌓기와 한 개 파기는 같은 weight
// 땅을 고른다 -> 평균을 맞춘다?
// 땅 고르는 시간이 가장 짧고, 고른 땅의 높이가 커야 함
// 높은 수부터 아래로 하나씩 줄여나가기?

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, m) = (input[0], input[1])
let b = input[2]
var board = Array<[Int]>()

for i in 0..<n {
    let line = readLine()!.split(separator: " ").compactMap { Int($0) }
    board.append(line)
}

func flatten(_ arr: [[Int]], _ b: Int, _ height: Int) -> Int {
    var remove = 0
    var add = 0
    for r in 0..<n {
        for c in 0..<m {
            if arr[r][c] < height {
                add += height - arr[r][c]
            } else if arr[r][c] > height {
                remove += arr[r][c] - height
            }
        }
    }
    guard add <= remove + b else { return -1 }

    return add + 2 * remove
}

var answer = Int(1e9)
var answerHeight = 0

for height in (0...256).reversed() {
    let time = flatten(board, b, height)
    guard time != -1 else { continue }

    if time < answer {
        answer = time
        answerHeight = height
    }
}

print(answer, answerHeight)
