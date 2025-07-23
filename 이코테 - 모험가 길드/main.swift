//
//  main.swift
//  이코테 - 모험가 길드
//

import Foundation

let n = Int(readLine()!)!
var data: [Int] = readLine()!.components(separatedBy: " ").map { Int($0)! }
data.sort(by: <)

var result = 0
var count = 0
for i in 0..<n {
    count += 1
    if count >= data[i] {
        result += 1
        count = 0
    }
}

print(result)
