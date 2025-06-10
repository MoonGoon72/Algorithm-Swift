//
//  main.swift
//  15483 - 최소 편집
//

import Foundation

let a = Array(readLine()!)
let b = Array(readLine()!)

func editDistance() -> Int {
    var edit = Array(repeating: Array(repeating: 0, count: b.count + 1), count: a.count + 1)
    
    for i in 1...b.count {
        edit[0][i] = i
    }
    for i in 1...a.count {
        edit[i][0] = i
    }
    
    for i in 1...a.count {
        for j in 1...b.count {
            if a[i - 1] == b[j - 1] {
                edit[i][j] = edit[i - 1][j - 1]
            } else {
                edit[i][j] = 1 + min(edit[i - 1][j - 1], edit[i - 1][j], edit[i][j - 1])
            }
        }
    }
    return edit[a.count][b.count]
}

print(editDistance())
