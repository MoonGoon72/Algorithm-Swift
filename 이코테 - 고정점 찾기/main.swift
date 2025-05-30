//
//  main.swift
//  이코테 - 고정점 찾기
//

import Foundation

let n = Int(readLine()!)!
let data = readLine()!.components(separatedBy: " ").map { Int($0)! }

func binary_search(_ arr: [Int], _ start: Int, _ end: Int) -> Int? {
    guard start <= end else { return nil }
    
    let mid = (start + end) / 2
    
    if arr[mid] == mid {
        return mid
    } else if arr[mid] < mid {
        return binary_search(arr, mid + 1, end)
    } else {
        return binary_search(arr, start, mid - 1)
    }
}

let answer = binary_search(data, 0, n - 1)

print(answer ?? -1)
/*
5
-15 -6 1 3 7
-> 3

7
-15 -4 2 8 9 13 15
-> 2

7
-15 -4 3 8 9 13 15
-> -1
 */
