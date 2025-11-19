//
//  main.swift
//  16928 - 뱀과 사다리 게임
//

import Foundation

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, m) = (input[0], input[1])

var board = Array(Range(0...100))
// 사다리
for _ in 0..<n {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    board[input[0]] = input[1]
}
// 뱀
for _ in 0..<m {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    board[input[0]] = input[1]
}


func solution(_ start: Int) -> Int {
    var answer = 0
    var visited = Array(repeating: false, count: 101)
    visited[start] = true

    var queue: [(v: Int, count: Int)] = [(start, 0)]
    var idx = 0

    while idx < queue.count {
        let (v, c) = queue[idx]
        idx += 1

        if v == 100 {
            answer = c
            return answer
        }

        for i in 1...6 {
            var nxt = v + i
            guard nxt <= 100, !visited[nxt]  else { continue }

            visited[nxt] = true
            nxt = board[nxt]
            queue.append((nxt, c + 1))
        }
    }

    return answer
}
let answer = solution(1)
print(answer)
