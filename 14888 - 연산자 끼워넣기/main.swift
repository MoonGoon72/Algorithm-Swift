//
//  main.swift
//  14888 - 연산자 끼워넣기
//

import Foundation

let n = Int(readLine()!)!
let numbers = readLine()!.components(separatedBy: " ").map { Int($0)! }
let operations = readLine()!.components(separatedBy: " ").map { Int($0)! }
let plus = operations[0], minus = operations[1], multiple = operations[2], divide = operations[3]

var min_value = Int.max
var max_value = Int.min

func dfs(_ depth: Int, _ acc: Int, _ plus: Int, _ minus: Int, _ multiple: Int, _ divide: Int) {
    guard depth < n else {
        min_value = min(min_value, acc)
        max_value = max(max_value, acc)
        return
    }
    
    if plus > 0 {
        dfs(depth + 1, acc + numbers[depth], plus - 1, minus, multiple, divide)
    }
    if minus > 0 {
        dfs(depth + 1, acc - numbers[depth], plus, minus - 1, multiple, divide)
    }
    if multiple > 0 {
        dfs(depth + 1, acc * numbers[depth], plus, minus, multiple - 1, divide)
    }
    if divide > 0 {
        dfs(depth + 1, acc / numbers[depth], plus, minus, multiple, divide - 1)
    }
}

dfs(1, numbers[0], plus, minus, multiple, divide)
print(max_value)
print(min_value)
