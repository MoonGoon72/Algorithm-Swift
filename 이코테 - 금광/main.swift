//
//  main.swift
//  이코테 - 금광
//

import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let (n, m) = (input[0], input[1])
    let data = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    var dp: [[Int]] = []
    
    var index = 0
    for _ in 0..<n {
        dp.append(Array(data[index..<index + m]))
        index += m
    }
    
    for j in 1..<m {
        var leftUp = 0
        var leftDown = 0
        for i in 0..<n {
            if i == 0 {
                leftUp = 0
            } else {
                leftUp = dp[i - 1][j - 1]
            }
            
            if i == n - 1 {
                leftDown = 0
            } else {
                leftDown = dp[i + 1][j - 1]
            }
            let left = dp[i][j - 1]
            dp[i][j] += max(leftUp, left, leftDown)
        }
    }
    
    let result: Int = dp.map({ $0.last! }).sorted(by: >)[0]
    print(result)
}
