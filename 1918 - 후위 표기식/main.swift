//
//  main.swift
//  1918 - 후위 표기식
//

import Foundation

let s = readLine()!.map { $0 }

var stack: [Character] = []
var answer = ""

func priority(_ c: Character) -> Int {
    switch c {
    case "*", "/": return 2
    case "+", "-": return 1
    default: return 0
    }
}

for ch in s {
    switch ch {
    case "A"..."Z":
        answer.append(ch)
    case "(":
        stack.append(ch)
    case ")":
        while let head = stack.last, head != "(" {
            answer.append(head)
            _ = stack.popLast()
        }
        _ = stack.popLast()
    case "+", "-", "*", "/":
        while let head = stack.last, priority(head) >= priority(ch) {
            answer.append(head)
            _ = stack.popLast()
        }
        stack.append(ch)
    default:
        break
    }
}

while let head = stack.last {
    answer.append(head)
    _ = stack.popLast()
}

print(answer)
