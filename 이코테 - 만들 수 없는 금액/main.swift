//
//  main.swift
//  이코테 - 만들 수 없는 금액
//

import Foundation

let n = Int(readLine()!)!
var data = readLine()!.components(separatedBy: " ").map { Int($0)! }
data.sort(by: <)

var target = 1
for v in data {
    if v <= target {
        target += v
    } else {
        break
    }
}
print(target)
