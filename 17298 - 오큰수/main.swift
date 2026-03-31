//
//  main.swift
//  17298 - 오큰수
//

import Foundation

let n = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").compactMap { Int($0) }

var stack: [Int] = []
var answer: [Int] = []

while let value = arr.popLast() {
    while let last = stack.last {
        if last > value {
            stack.append(value)
            answer.append(last)
            break
        } else {
            stack.popLast()
        }
    }
    if stack.isEmpty {
        answer.append(-1)
        stack.append(value)
        continue
    }
}
print(answer.reversed().map { String($0) }.joined(separator: " "))
