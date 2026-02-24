//
//  main.swift
//  1182 - 부분수열의 합
//

import Foundation

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, s) = (input[0], input[1])
let arr = readLine()!.split(separator: " ").compactMap { Int($0) }

func recursion(_ idx: Int, _ acc: Int, _ tmp: [Int]) {
    if idx == arr.count {
        if acc == s && !tmp.isEmpty {
            answer += 1
        }
        return
    }

    // 선택
    recursion(idx + 1, acc + arr[idx], [arr[idx]] + tmp)
    // 비선택
    recursion(idx + 1, acc, tmp)
}

var answer = 0
recursion(0, 0, [])
print(answer)
