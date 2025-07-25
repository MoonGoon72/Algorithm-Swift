//
//  main.swift
//  이코테 - 볼링공 고르기
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
let data = readLine()!.components(separatedBy: " ").map { Int($0)! }

//func combinations<T>(_ array: [T], count: Int) -> [[T]] {
//    if count == 0 {
//        return [[]]
//    }
//    
//    guard let first = array.first else {
//        return []
//    }
//    
//    let head = [first]
//    let subCombinations = combinations(Array(array.dropFirst()), count: count - 1).map { head + $0 }
//    return subCombinations + combinations(Array(array.dropFirst()), count: count)
//}
//
//print(combinations(data, count:2).filter { $0[0] != $0[1] }.count)

//var answer = 0
//for i in 0..<n - 1 {
//    for j in i + 1..<n {
//        if data[i] != data[j] {
//            answer += 1
//        }
//    }
//}
//
//print(answer)

var array = Array(repeating: 0, count: m + 1)
for v in data {
    array[v] += 1
}

var answer = 0
var num = n
for i in 1..<m + 1 {
    num -= array[i]
    answer += array[i] * num
}

print(answer)

let arr = [1, 2, 3, 4, 5]
