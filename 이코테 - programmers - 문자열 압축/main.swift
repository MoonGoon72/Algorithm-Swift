//
//  main.swift
//  이코테 - programmers - 문자열 압축
//

import Foundation

let input = readLine()!

func solution(_ s: String) -> Int {
    let sequence = Array(s)
    let n = s.count
    var answer = n
    
    for step in 1..<(n / 2 + 1) { // 나누는 단위 완전탐색
        var compressed = ""
        var prev = Array(sequence[0..<step])
        var count = 1
        
        for i in stride(from: step, to: n, by: step) {
            let now = Array(sequence[i..<i + step])
            if prev == now {
                count += 1
            } else {
                compressed += count == 1 ? prev : String(count) + prev
                prev = now
                count = 1
            }
        }
        compressed += count == 1 ? prev : String(count) + prev
        answer = min(answer, compressed.count)
    }
    
    return answer
}

print(solution(input))
