//
//  main.swift
//  9251 - LCS
//

import Foundation

let seq1 = Array(readLine()!)
let seq2 = Array(readLine()!)

var lcs = Array(repeating: Array(repeating: 0, count: seq1.count + 1), count: seq2.count + 1)
let l = seq1.count

for i in 1..<seq2.count + 1 {
    for j in 1..<seq1.count + 1 {
        if seq1[j - 1] == seq2[i - 1] {
            lcs[i][j] = lcs[i - 1][j - 1] + 1
        } else {
            lcs[i][j] = max(lcs[i - 1][j], lcs[i][j - 1])
        }
    }
}

let answer = lcs.compactMap { $0.sorted(by: >).first }.sorted(by: >).first!
print(answer)
