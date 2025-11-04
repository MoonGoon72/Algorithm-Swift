//
//  main.swift
//  1759 - 암호 만들기
//

import Foundation

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (l, c) = (input[0], input[1])
let chars = readLine()!.split(separator: " ").map{ String($0) }

func combinations(_ arr: [String], _ count: Int) -> [[String]] {
    if count == 0 { return [[]] }
    guard let first = arr.first else { return [] }
    
    let head = [first]
    let subCombinations = combinations(Array(arr.dropFirst()), count - 1).map { head + $0 }
    return subCombinations + combinations(Array(arr.dropFirst()), count)
}

func check(_ arr: [String]) -> Bool {
    let vowel = ["a", "e", "i", "o", "u"]
    var vowelCount = 0
    var consonantCount = 0
    for e in arr {
        if vowel.contains(e) {
            vowelCount += 1
        } else {
            consonantCount += 1
        }
    }
    return vowelCount > 0 && consonantCount > 1
}

var combs = combinations(chars, l).map { $0.sorted(by: < ) }
combs.sort { $0.joined(separator: "") < $1.joined(separator: "") }

for comb in combs {
    if check(comb) {
        print(comb.joined())
    }
}
