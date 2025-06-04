//
//  main.swift
//  2110 - 공유기 설치
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, c) = (input[0], input[1])
var data: [Int] = []
for _ in 0..<n {
    let num = Int(readLine()!)!
    data.append(num)
}
data.sort()

var start = 0
var end = data[n - 1]
var answer = 0

while start <= end {
    let mid = (start + end) / 2
    var value = data[0]
    var count = 1
    
    for i in 1..<n {
        if data[i] - value >= mid {
            count += 1
            value = data[i]
        }
    }
    if count >= c {
        answer = mid
        start = mid + 1
    } else {
        end = mid - 1
    }
}

print(answer)
