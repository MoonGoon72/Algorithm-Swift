//
//  main.swift
//  이코테 - 곱하기 혹은 더하기
//

import Foundation

let input = Array(readLine()!)
var result = 0

for c in input {
    let num = Int(String(c))!
    if num == 0 || result == 0 {
        result += num
    } else {
        result *= num
    }
}
print(result)
