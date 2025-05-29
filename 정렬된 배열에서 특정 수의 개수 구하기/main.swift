//
//  main.swift
//  정렬된 배열에서 특정 수의 개수 구하기
//

import Foundation

let inputs = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, x) = (inputs[0], inputs[1])
let sequence = readLine()!.components(separatedBy: " ").map { Int($0)! }

func first(_ arr: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int? {
    guard start <= end else { return nil }
    
    let mid = (start + end) / 2
    if (mid == 0 || arr[mid - 1] < target) && arr[mid] == target {
        return mid
    } else if arr[mid] >= target {
        return first(arr, target, start, mid - 1)
    } else {
        return first(arr, target, mid + 1, end)
    }
}

func last(_ arr: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int? {
    guard start <= end else { return nil }
    
    let mid = (start + end) / 2
    if (mid == n - 1 || arr[mid + 1] > target) && arr[mid] == target {
        return mid
    } else if arr[mid] > target {
        return last(arr, target, start, mid - 1)
    } else {
        return last(arr, target, mid + 1, end)
    }
}

func solution() {
    let left = first(sequence, x, 0, n - 1)
    let right = last(sequence, x, 0 ,n - 1)
    
    guard let left, let right else {
        print(-1)
        return
    }
    print(right - left + 1)
}

solution()
/*
7 2
1 1 2 2 2 2 3
 
4

7 4
1 1 2 2 2 2 3

-1
*/
