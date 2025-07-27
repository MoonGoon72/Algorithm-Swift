//
//  main.swift
//  이코테 - boj - 18406 - 럭키 스트레이트
//

import Foundation

func solution1() {
    let input = Array(readLine()!)
    let middle = input.count / 2
    
    let leftSum = Array(input[0..<middle]).reduce(0) { Int(String($0))! + Int(String($1))! }
    let rightSum = Array(input[middle...]).reduce(0) { Int(String($0))! + Int(String($1))! }
    
    leftSum == rightSum ? print("LUCKY") : print("READY")
}

func solution2() {
    let s = readLine()!
    let half = s.count / 2
    
    let diff = s.enumerated().reduce(0) { acc, pair in
        let (i, ch) = pair
        let value = ch.wholeNumberValue!
        return i < half ? acc + value : acc - value
    }
    
    print(diff == 0 ? "LUCKY" : "READY")
}

solution2()
